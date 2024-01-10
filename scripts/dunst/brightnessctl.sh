#!/usr/bin/env bash

msgId="42069"

if [[ $1 == "up" ]]; then
brightnessctl set 3%+
else
brightnessctl set 3%-
fi

brightness="$(brightnessctl -m | awk -F ',' '{ print $4 }')"

dunstify -a "changeBrightness" -i solaar-indicator -r "$msgId" -h int:value:"$brightness" "Brightness: ${brightness}"
