#!/usr/bin/env sh

# Synopsis:
# Bootstrap a test runner repo

# Example:
# LANGUAGE=Ruby SLUG=ruby ./bin/bootstrap.sh

# If any required arguments is missing, print the usage and exit
if [ -z "${LANGUAGE}" ] || [ -z "${SLUG}" ]; then
    echo "usage: LANGUAGE=<language> SLUG=<slug> ./bin/bootstrap.sh"
    exit 1
fi

REPO="exercism/${SLUG}-test-runner"
gh repo create --public --template https://github.com/exercism/generic-test-runner/ "${REPO}"
gh api --method PATCH "/repos/${REPO}" -f allow_merge_commit=false -f allow_rebase_merge=false
gh api --method PUT "/orgs/exercism/teams/maintainers-admin/repos/${REPO}" -f "permission=maintain"
gh api --method PUT "/orgs/exercism/teams/${SLUG}/repos/${REPO}" -f "permission=push"
