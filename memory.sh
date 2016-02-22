#!/bin/sh

USED="$(free -m | awk '/^Mem:/{print $3}')"
USED_GB=$(echo "scale=2;$USED/1000" | bc)
TOTAL="$(free -m | awk '/^Mem:/{print $2}')"
TOTAL_GB=$(echo "scale=2;$TOTAL/1000" | bc)

if echo $USED_GB | grep -q '^\.'; then
	echo 0$USED_GB GB/$TOTAL_GB GB;
else
	echo $USED_GB GB/$TOTAL_GB GB;
fi
