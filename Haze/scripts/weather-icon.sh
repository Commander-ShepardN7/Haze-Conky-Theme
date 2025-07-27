#!/bin/bash

# Credits to Closebox 73

# theme value must be same with folder name in icons folder
weather_code=$(cat ~/.cache/weather.json | jq -r '.weather[0].icon')

if [[  ! -e ~/.cache/weather.json || ${weather_code} == "null" ]]; then
	cp -r ~/.config/conky/Haze/icons/unknown.png ~/.cache/weather-icon.png
	else
	cp -r ~/.config/conky/Haze/icons/${weather_code}.png ~/.cache/weather-icon.png
fi
exit
