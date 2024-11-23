#!/bin/bash

#Establish the command line arguments
if [ $@ -ge 1 ]; then
	SEARCH_FILES="1"
fi
if [ $@ -ge 2 ]; then
        NUMBER_LINES="2"
fi

#Check that it functions this script to determine if the file contains nucleotides or aminoacids
file="1"
seq=$grep -v "^>" "$file" | tr -d '\n' | tr -d '-' | tr -d ' ')
total_chars=${#seq}
#In this part we can mention that if the file has a ACGTN it is considered 
a nucleotide becuase of its structure
nucleotide_chars=$(echo "$seq" | grep -o '[ACGTNacgtn]' | wc -c)
percentage=$((nucleotide_chars * 100 / total_chars))

if [ $percentage -ge 90 ]; then
	echo "Nucleotide"
else 
	echo "Aminoacid"
fi
}
