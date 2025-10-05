#!/bin/bash

if [ $# -lt 2 ]; then
    echo "Usage: $0 <example_folder> <input_file>"
    exit 1
fi

EXAMPLE=$1
INPUT=$2
BUILD_DIR=build
OUTPUT=$EXAMPLE/${INPUT%%.*}_parser_output.txt

# Run parser and redirect output
echo "Parsing Input"
java -cp $BUILD_DIR parser < "$EXAMPLE/$INPUT" > "$OUTPUT"

# Step 2: Check if output contains valid instruction lines (starts with number + opcode)
if grep -Eq '^[0-9]+[[:space:]]+[A-Z]+' "$OUTPUT"; then
    echo "✅ Valid parse detected — running Machine..."
    java -cp $BUILD_DIR Machine "$OUTPUT"
else
    echo "❌ No valid code generated. Possible syntax or parsing error."
    echo "------ Parser Output ------"
    cat "$OUTPUT"
    echo "---------------------------"
    exit 1
fi
