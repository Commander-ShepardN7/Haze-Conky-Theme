#!/bin/bash

# based on original Script by Closebox73
# modified by Commander-ShepardN7
# Script to get Spotify playerctl status

PCTL=$(playerctl -p spotify status 2>/dev/null)

if [[ -z "$PCTL" ]]; then
    echo "-"
else
    title=$(playerctl -p spotify metadata xesam:title 2>/dev/null)
    if (( ${#title} > 29 )); then
        echo "${title:0:29}..."
    else
        echo "$title"
    fi
fi

exit

