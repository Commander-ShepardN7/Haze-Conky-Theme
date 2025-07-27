#!/bin/bash
#Commander-ShepardN7
# Get the current player status
STATUS=$(playerctl --player=spotify status 2>/dev/null)

# Display song information based on player status
if [ "$STATUS" == "Playing" ]; then
  echo "Now playing:"
elif [ "$STATUS" == "Paused" ]; then
  echo "Paused"
else
  echo "No music playing."
fi

