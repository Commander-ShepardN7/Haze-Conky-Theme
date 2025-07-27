#!/bin/bash
#Commander-ShepardN7
ARTIST=$(playerctl --player=spotify metadata artist)
ALBUM=$(playerctl --player=spotify metadata album | fold -s -w 25)

# Get player status
STATUS=$(playerctl --player=spotify status 2>/dev/null)

# Display informations
if [ "$STATUS" == "Playing" ] || [ "$STATUS" == "Paused" ]; then
    if (( ${#ARTIST} > 32 )); then
        echo "${ARTIST:0:32}..."
    else
        echo "$ARTIST"
    fi
else
    echo ""
fi


