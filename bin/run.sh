#! /bin/bash -e
SLUG="$1"
INPUT_DIR="$2"
OUTPUT_DIR="$3"

echo "Testing $SLUG..."
# PLACEHOLDER - Insert call to run your language tests here

echo "Processing test output in $INPUT_DIR..."
# PLACEHOLDER - OPTIONAL: Your language may support outputting results
#   in the correct format

# Create $OUTPUT_DIR if it doesn't exist
[ -d "$OUTPUT_DIR" ] || mkdir -p "$OUTPUT_DIR"

echo "Copying processed results to $OUTPUT_DIR..."
# PLACEHOLDER - OPTIONAL: Your language may support placing results
#   directly in $OUTPUT_DIR
cp "${INPUT_DIR}/results.json" "$OUTPUT_DIR"

echo "Comparing ${OUTPUT_DIR}/results"
diff "${INPUT_DIR}/results.json" "${OUTPUT_DIR}/results.json"
