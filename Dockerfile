FROM alpine:3.10

# TODO: install packages required to run the tests
# RUN apk add --no-cache coreutils

COPY . /opt/test-runner
WORKDIR /opt/test-runner
ENTRYPOINT ["/opt/test-runner/bin/run.sh"]
