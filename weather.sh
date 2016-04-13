#!/bin/bash

function get {
	echo $(xmllint --xpath "string($2)" - <<< "$1")
}

function get_icon {
	CODE=$(get "$1" "//current/weather/@number")
	case $CODE in
		# Thunderstorm
		200|201|202|230|231|232)
			echo "<span font='Weather Icons 10' color='#9990b2'></span>"
		;;
		# Lightning
		210|211|212|221)
			echo "<span font='Weather Icons 10' color='#9990b2'></span>"
		;;
		# Rain
		300|301|302|310|311|312|313|314|321|500|501|502|503|504|511|520|521|701)
			echo "<span font='Weather Icons 10' color='#9990b2'></span>"
		;;
		# Snow
		600|601|602|621|622|903)
			echo "<span font='Weather Icons 10' color='#9990b2'></span>"
		;;
		# Fog
		741)
			echo "<span font='Weather Icons 10' color='#9990b2'></span>"
		;;
		# Clouds
		771|801|802|803|804)
			echo "<span font='Weather Icons 10' color='#9990b2'></span>"
		;;
		# Sunny
		800|904)
			echo "<span font='Weather Icons 10' color='#9990b2'></span>"
		;;
		*)
			echo "FIXME"
		;;
	esac

}

function update {
	WEATHER_INFO=$(curl -s "http://api.openweathermap.org/data/2.5/weather?q=$1&APPID=$2&mode=xml&units=metric")
	if [ $? -ne 0 ]; then
		exit 1
	fi
	echo "$WEATHER_INFO" >> /tmp/weather.xml
	#WEATHER_INFO=$(cat /home/avano/work/git/github/i3/weather.xml)
	ICON=$(echo $(get_icon "$WEATHER_INFO"))
	TEMP=$(echo $(get "$WEATHER_INFO" "//current/temperature/@value"))
	STATUS="$TEMP°C   "
	rm -rf /tmp/weather_icon
	rm -rf /tmp/weather_info
	rm -rf /tmp/weather_last_updated
	echo "$ICON" >> /tmp/weather_icon
	echo "$STATUS" >> /tmp/weather_info
	echo $(date +%s) >> /tmp/weather_last_updated

}

if [ -f /tmp/weather_last_updated ]; then 
	LAST_UPDATED=$(cat /tmp/weather_last_updated)
	if [ `expr $(date +%s) - $LAST_UPDATED` -gt 900 ]; then
		update $1 $2
	fi
else
	update $1 $2
fi
echo $(cat /tmp/weather_info)
