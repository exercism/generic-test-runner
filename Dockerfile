FROM alpine:3.10

# TODO: install packages required to run the tests
# RUN apk add --no-cache coreutils

WORKDIR /opt/test-runner
COPY . .
ENTRYPOINT ["/opt/test-runner/bin/run.sh"]
