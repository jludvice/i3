#!/bin/sh
# Copyright (C) 2014 Julien Bonjean <julien@bonjean.info>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

INSTANCE="${1:-BAT0}"
ALERT_LOW="${2:-10}" # color will turn red under this value (default: 10%)
UPOWER="/usr/bin/upower"

if [ ! -x "$UPOWER" ]; then
	echo "upower not found"
	exit 1
fi

$UPOWER -i /org/freedesktop/UPower/devices/battery_$INSTANCE |
	awk -v alert_low=$ALERT_LOW '
/state:/ {
	state = $2
}
/time to full:/ {
	remaining_time = $4 " " substr ($5, 0, 1)
}
/time to empty:/ {
	remaining_time = $4 " " substr ($5, 0, 1)
}
/percentage:/ {
	percentage = $2;
}
END {
	if (state == "charging")
		label = " CHR"
	else if (state == "fully-charged")
		label = " "
	else
		label = " BAT"
	# full text
	print label " " percentage \
		(state == "fully-charged" ? "" : " " remaining_time)
	# short text
	print label " " percentage
	# color
	gsub(/%$/,"",percentage)
	if (+ percentage < + alert_low)
		print "#FF0000"
}
'
