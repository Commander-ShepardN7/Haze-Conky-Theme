#!/bin/bash
#Commander-ShepardN7
# Weather Forecast Script v1.1 based on CloseBox73's Weather script
# Retrieves and saves tomorrow's forecast (min and max temp) from OpenWeatherMap

# Config
city_id= #yourcityID
api_key= #yourAPIkey
unit=metric
lang=en

# Output file
output_file="$HOME/.cache/weather_forecast.json"

# API endpoint (5-day forecast in 3-hour intervals)
url="https://api.openweathermap.org/data/2.5/forecast?id=${city_id}&appid=${api_key}&units=${unit}&lang=${lang}"

# Download JSON
curl -s "$url" -o "$output_file"

# Extract tomorrow's date
tomorrow=$(date -d "+1 day" +%Y-%m-%d)

# Get temps for tomorrow using jq (you must have jq installed)
jq --arg date "$tomorrow" '
  .list
  | map(select(.dt_txt | startswith($date)))
  | {
      min: (map(.main.temp_min) | min),
      max: (map(.main.temp_max) | max)
    }
' "$output_file" > "$HOME/.cache/weather_tomorrow.json"

exit

