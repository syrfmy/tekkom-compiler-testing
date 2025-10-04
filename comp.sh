#!/bin/bash

if [ $# -lt 1 ]; then
    echo "Usage: $0 <example_folder>"
    exit 1
fi

EXAMPLE=$1
BUILD_DIR=build
mkdir -p $BUILD_DIR

# Clear build


# Step 1: Generate lexer using JLex
LEX_FILE=$(basename $EXAMPLE/*.lex)
java JLex.Main $EXAMPLE/$LEX_FILE

# Rename to Yylex.java in build folder
mv "$EXAMPLE/${LEX_FILE}.java" $BUILD_DIR/Yylex.java

# Step 2: Generate parser using CUP
CUP_FILE=$(basename $EXAMPLE/*.cup)
java java_cup.Main $EXAMPLE/$CUP_FILE
mv parser.java build/parser.java
mv sym.java build/sym.java


# Step 3: Copy additional classes to build folder
cp ./additional_class/*.java $BUILD_DIR/

# Step 4: Compile all Java files in build folder
javac -d $BUILD_DIR -cp $BUILD_DIR $BUILD_DIR/*.java

echo "Compilation finished. All classes are in $BUILD_DIR"

