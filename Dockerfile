FROM alpine:3.10

# Uncomment to install depenencies
# RUN apk add --no-cache coreutils

COPY . /opt/test-runner
WORKDIR /opt/test-runner
ENTRYPOINT ["/opt/test-runner/bin/run.sh"]
