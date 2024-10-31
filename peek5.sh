
FILE=$1

if [[ -n $2 ]]; then
LINES=$2;
else
LINES=3;
fi

(head -n $LINES $FILE  && tail -n $LINES $FILE)


 
