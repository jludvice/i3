#!/usr/bin/env bash

LIGHTNING="<span color='yellow' font='FontAwesome'></span>"
PLUG="<span font='FontAwesome'></span>"

function handleFull {
	printf "100%%"
}

function handleDischarging {
	ROW=$(echo "$1" | grep Discharging)
        if [ $? = 0 ]; then
                PERCENTAGE=$(echo "$ROW" | grep -o '.[0-9]%')
                printf "$PERCENTAGE%"
                REMAINING=$(echo "$ROW" | grep -o '[0-9][0-9]:[0-9][0-9]:[0-9][0-9]')
                if [ $? = 0 ]; then
                        printf " (${REMAINING:1:4})"
                fi
                exit 0
        fi
}

function handleCharging {
	ROW=$(echo "$1" | grep Charging)
        if [ $? = 0 ]; then
		PERCENTAGE=$(echo "$ROW" | grep -o '.[0-9]%')
		printf "$PLUG $PERCENTAGE%"
		REMAINING=$(echo "$ROW" | grep -o '[0-9][0-9]:[0-9][0-9]:[0-9][0-9]')
		if [ $? = 0 ]; then
			printf " (${REMAINING:1:4})"
		fi
		exit 0
        fi
}

ACPI_OUTPUT=$(acpi)
printf "$LIGHTNING "

handleDischarging "$ACPI_OUTPUT"
handleCharging "$ACPI_OUTPUT"
handleFull "$ACPI_OUTPUT"
