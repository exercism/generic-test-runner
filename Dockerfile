FROM alpine:3.10

# Uncomment to install depenencies
# RUN apk add --no-cache coreutils

WORKDIR /opt/test-runner
COPY run.sh bin/
COPY process_results.py ./
ENTRYPOINT ["/opt/test-runner/bin/run.sh"]
