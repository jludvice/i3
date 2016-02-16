#!/bin/sh
#~/scripts/i3blocks/blocklets/memory.sh
# show total and used memory by Derrick Cope

USED="$(free -m | awk '/^Mem:/{print $3}')"
USED_GB=$(echo "scale=2;$USED/1000" | bc)
TOTAL="$(free -m | awk '/^Mem:/{print $2}')"
TOTAL_GB=$(echo "scale=2;$TOTAL/1000" | bc)
CACHED="$(free -m | awk '/^Mem:/{print $6}')"
FREE="$(free -m | awk '/^Mem:/{print $4}')"
UNUSED="$[$CACHED + $FREE]"

case $BLOCK_BUTTON in
  3) echo $UNUSED/$TOTAL ;;
  2) echo $USED/$TOTAL  ;;
  1)
esac

echo $USED_GB GB/$TOTAL_GB GB
