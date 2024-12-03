#!/bin/bash
# Script for finding all FASTA and .fa files

# Establish the command-line arguments 
SEARCH_FILES=${1:-"."}   
NUM_LINES=${2:-3}  

# Check that it functions this script to determine if the file contains 
nucleotides 
# or amino acids 
determine_sequence_type() {
    seq=$(grep -v "^>" "$1" | tr -d '\n-')
    nucleotide_count=$(echo "$seq" | grep -o '[ACGTNacgtn]' | wc -c)
    total_length=${#seq}
    if [ $nucleotide_count -ge $((total_length * 9 / 10)) ]; then
        echo "Nucleotide"
    else
        echo "Amino Acid"
    fi
}

# Find all FASTA and .fa files
FILES=$(find "$SEARCH_FILES" -type f \( -name "*.fa" -o -name "*.fasta" \) 
! -path "*/.*")
FILE_COUNT=$(echo "$FILES" | grep -c "^")

# Count total unique FASTA IDs across all files
TOTAL_IDS=$(grep "^>" $FILES 2>/dev/null | cut -d ' ' -f1 | sort -u | wc 
-l)

echo "=== FASTA Files Report ==="
echo "Total FASTA files: $FILE_COUNT"
echo "Total unique FASTA IDs: $TOTAL_IDS"
echo "========================="

#Determine if the file is a symbolic link or regular file
while IFS= read -r file; do
    [ -z "$file" ] && continue
    echo -e "\n### File: $file"
    echo "Type: $([ -L "$file" ] && echo "Symbolic Link -> $(readlink 
"$file")" || echo "Regular File")"

#Determine de number of sequences, total sequence length and sequence type
    SEQ_COUNT=$(grep -c "^>" "$file")
    echo "Number of sequences: $SEQ_COUNT"
    echo "Total sequence length: $(grep -v "^>" "$file" | tr -d '\n- ' | 
wc -c)"
    echo "Sequence type: $(determine_sequence_type "$file")"

    # Display file content based on NUM_LINES
    FILE=$file
    if [[ -n $NUM_LINES ]]; then
        LINES=$NUM_LINES
    else
        LINES=3
    fi

    TOTLINES=$(wc -l < "$FILE")

    if ((TOTLINES <= 2 * LINES)); then 
        echo "File Content:"
        cat "$FILE"
    else
        echo "File Content (This is the first and the last ${LINES} lines."
        head -n "$LINES" "$FILE"
        echo "..."
        tail -n "$LINES" "$FILE"
    fi

    # Establish a separator to distinguish output for the different files
    echo "------------------------"
done <<< "$FILES"

