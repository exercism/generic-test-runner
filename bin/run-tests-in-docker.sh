#! /bin/bash -e

# build docker image
docker build --rm --no-cache -t generic-test-runner .

docker run \
    --network none \
    --read-only \
    --mount type=bind,src=$PWD/$testdir,dst=/solution \
    --mount type=bind,src=$PWD/test/output/,dst=/output \
    --mount type=tmpfs,dst=/tmp \
    generic-test-runner --entrypoint /opts/test-runner/bin/run-all.sh /solution/
