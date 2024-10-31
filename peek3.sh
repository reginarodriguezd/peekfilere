    exit 1
fi

# Assign arguments to variables
FILE="$1"
LINES="$2"

# Print the first $LINES lines
head -n "$LINES" "$FILE"
echo "..."
# Print the last $LINES lines
tail -n "$LINES" "$FILE"
