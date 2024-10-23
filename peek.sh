#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

FILE=$1

if [ ! -f "$FILE" ]; then
    echo "File not found!"
    exit 1
fi

# Get the total number of lines in the file
TOTAL_LINES=$(wc -l < "$FILE")

# Calculate the number of lines to print
if [ "$TOTAL_LINES" -le 6 ]; then
    cat "$FILE"
else
    # Print the first three lines
    head -n 3 "$FILE"
    echo "..."
    # Print the last three lines
    tail -n 3 "$FILE"
fi

