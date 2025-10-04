#!/bin/bash

if [ $# -lt 2 ]; then
    echo "Usage: $0 <example_folder> <input_file>"
    exit 1
fi

EXAMPLE=$1
INPUT=$2
BUILD_DIR=build
OUTPUT=$EXAMPLE/parser_output.txt

# Run parser
java -cp $BUILD_DIR parser < $EXAMPLE/$INPUT > $OUTPUT

# Run Machine
java -cp $BUILD_DIR Machine $OUTPUT
