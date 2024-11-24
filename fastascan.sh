#!/bin/bash
#Script for finding all fasta and fa files
#Establish the command line arguments
if [ "$#" -ge 1 ]; then
	SEARCH_FILES="1"
fi
if [ $@ -ge 2 ]; then
        NUMBER_LINES="2"
fi

#Check that it functions this script to determine if the file contains nucleotides or aminoacids
determine_sequence_type(){
	seq=$grep -v "^>" "$1" | tr -d '\n-')
	[ $(echo "$seq" | grep -o '[ACGTNacgtn]' | wc -c) -ge $((${#seq} * 9 / }
FILES=$(find "SEARCH_FILES" -type f -o -type l -name "*.fa" -o -name "*.fasta")
FILE_COUNT=$(echo "$FILES" | grep -c "^")
#Count total unique FASTA IDs across all files
TOTAL_IDS=$(grep "^>" $FILES | cut -d ' ' -f1 | sort -u | wc -l)

echo "=== FASTA Files Report ==="
echo "Total FASTA files: $FILE_COUNT
Total unique FASTA IDs: $TOTAL_IDS
========================="

while IFS= read -r file; do
	[-z "$file" ] && continue
	echo -e "\n### File: $file"
	echo "Type: $([ -L "$file" ] && echo "Symbolic Link -> $(readlink "$file")" || echo "Regular 
File")"
	SEQ_COUNT:$(grep -c "^>" "$file")
	echo "Number of sequences: $SEQ_COUNT"
	echo "Total sequence length: $(grep -v "^>" "$file" | tr -d '\n- ' | wc -c)"
	echo "Sequence type: $(determine_sequence_type "$file")"
	
#Put a conditional to check that if they are bigger than 0 they print different
if [$NUM_LINES -gt 0 ]; then
	TOTAL_LINES=$(wc -l < "$file")
	if [ TOTAL_LINES -le $((2*NUM_LINES)) ]; then
	echo "File Content:"
	cat "$file"
     else
	echo "File Content (This is the first and the last $NUM_LINES lines);"
	head -n $NUM_LINES "$file"
	ECHO "..."
	tail -n $NUM_LINES "$file"
     fi
fi

#Establish a separator to distinguish output for the different files
echo "------------------------"
done <<< "$FILES"
	
