FROM alpine:3.10

# Uncomment to install depenencies
# RUN apk add --no-cache coreutils

WORKDIR /opt/test-runner
COPY ./bin/ bin/
ENTRYPOINT ["/opt/test-runner/bin/run.sh"]
