#! /bin/bash -e

# build docker image
docker build --rm --no-cache -t generic-test-runner .

for testdir in test/*; do
    testname="$(basename $testdir)"
    if [ "$testname" != output ] && [ -f "${testdir}/results.json" ]; then
        docker run \
            --mount type=bind,src=$PWD/$testdir,dst=/solution \
            --mount type=bind,src=$PWD/test/output/,dst=/output \
            generic-test-runner $testname /solution/ /output/
    fi
done
