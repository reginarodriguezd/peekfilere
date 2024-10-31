
FILE=$1

if [[ -n $2 ]]; then
LINES=$2;
else
LINES=3;
fi;

TOTLINES=$(wc -l < "$FILE")

if ((TOTLINES <= 2 * LINES)); then 
	cat "$FILE"
else
	echo "Warning message: The file contains more than ${LINES} last 
lines."
	head -n "$LINES" "$FILE"
	echo "..."
	tail -n "$LINES" "$FILE"
fi

(head -n $LINES $FILE  && tail -n $LINES $FILE)


 
