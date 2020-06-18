#! /bin/bash -e

for testdir in test/*; do
    testname="$(basename $testdir)"
    if [ "$testname" != output ] && [ -f "${testdir}/results.json" ]; then
        bin/run.sh "$testname" "$testdir" test/output/
    fi
done
