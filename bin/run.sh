#! /bin/sh
set -e

SLUG="$1"
INPUT_DIR="$2"
OUTPUT_DIR="$3"

echo "$SLUG: testing..."
# PLACEHOLDER - Insert call to run your language tests here

echo "$SLUG: processing test output in $INPUT_DIR..."
# PLACEHOLDER - OPTIONAL: Your language may support outputting results
#   in the correct format

# Create $OUTPUT_DIR if it doesn't exist
[ -d "$OUTPUT_DIR" ] || mkdir -p "$OUTPUT_DIR"

echo "$SLUG: copying processed results to $OUTPUT_DIR..."
# PLACEHOLDER - OPTIONAL: Your language may support placing results
#   directly in $OUTPUT_DIR
cp "${INPUT_DIR}/results.json" "$OUTPUT_DIR"

echo "$SLUG: comparing ${OUTPUT_DIR}/results"
diff "${INPUT_DIR}/results.json" "${OUTPUT_DIR}/results.json"

echo "$SLUG: OK"
