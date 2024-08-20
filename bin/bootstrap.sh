#!/usr/bin/env bash

# Synopsis:
# Bootstrap a test runner repo

# Example:
# LANGUAGE=Ruby SLUG=ruby bin/bootstrap.sh

set -euo pipefail

scriptname="${0}"

help_and_exit() {
    echo >&2 "Create a test runner repository for a track."
    echo >&2 "Usage: LANGUAGE=<language> SLUG=<slug> ${scriptname}"
    exit 1
}

die() { echo >&2 "$*"; exit 1; }

required_tool() {
    command -v "$1" >/dev/null 2>&1 ||
        die "$1 is required but not installed. Please install it and make sure it's in your PATH."
}

# If any required arguments is missing, print the usage and exit
if [ -z "${LANGUAGE}" ] || [ -z "${SLUG}" ]; then
    help_and_exit
fi

required_tool gh
required_tool jq

ORG="exercism"
REPO="${ORG}/${SLUG}-test-runner"

# Create clone of this repo with track slug and name replaced
REPO_DIR=$(mktemp -d)
cp -a . "${REPO_DIR}"
cd "${REPO_DIR}" || die "Failed to cd to ${REPO_DIR}"

for file in $(git grep --files-with-matches TRACK_SLUG); do
    sed -i "s/TRACK_SLUG/${SLUG}/g" "${file}"
done

for file in $(git grep --files-with-matches TRACK_NAME); do
    sed -i "s/TRACK_NAME/${LANGUAGE}/g" "${file}"
done

rm -f bin/bootstrap.sh
rm -rf .git
mv TRACK_README.md README.md
git init
git add .
git commit -am "Initial commit"
gh repo create "${REPO}" --public --push --source=.

# Disable merge commits and rebase merges
gh api --method PATCH "/repos/${REPO}" -f "allow_merge_commit=false" -f "allow_rebase_merge=false"

# Update team permissions
gh api --method PUT "/orgs/${ORG}/teams/maintainers-admin/repos/${REPO}" -f "permission=maintain"
gh api --method PUT "/orgs/${ORG}/teams/guardians/repos/${REPO}" -f "permission=push"
gh api --method PUT "/orgs/${ORG}/teams/${SLUG}/repos/${REPO}" -f "permission=push"

# Add repo to deploy secrets
REPO_ID=$(gh api "repos/${REPO}" --jq '.id')
gh api --method PUT "/orgs/${ORG}/actions/secrets/AWS_ECR_ACCESS_KEY_ID/repositories/${REPO_ID}"
gh api --method PUT "/orgs/${ORG}/actions/secrets/AWS_ECR_SECRET_ACCESS_KEY/repositories/${REPO_ID}"
gh api --method PUT "/orgs/${ORG}/actions/secrets/DOCKERHUB_PASSWORD/repositories/${REPO_ID}"
gh api --method PUT "/orgs/${ORG}/actions/secrets/DOCKERHUB_USERNAME/repositories/${REPO_ID}"

# Create ruleset for default branch
jq -n '{name: "Default branch", target: "branch", enforcement: "active", conditions: {ref_name: {include: ["~DEFAULT_BRANCH"], exclude:[]}}, rules:[{type: "pull_request", parameters: {dismiss_stale_reviews_on_push: false, require_code_owner_review: true,require_last_push_approval: false, required_approving_review_count: 0, required_review_thread_resolution: false}}], "bypass_actors":[{"actor_id": 1, "actor_type": "OrganizationAdmin", "bypass_mode": "always"}]}' | gh api --method POST "/repos/${REPO}/rulesets" --input -

# Add topics
gh api --method PUT "/repos/${REPO}/topics" -f "names[]=exercism-test-runner" -f "names[]=exercism-tooling"
