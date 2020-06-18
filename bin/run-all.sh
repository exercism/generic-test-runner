#! /bin/sh
set -e

output_dir="${1:-test/output/}"

for testdir in test/*; do
    testname="$(basename $testdir)"
    if [ "$testname" != output ] && [ -f "${testdir}/results.json" ]; then
        bin/run.sh "$testname" "$testdir" "$output_dir"
    fi
done
