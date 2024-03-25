#!/usr/bin/env bash

# Execute hyprpicker and save the output to a variable
hyprpicker -a -n -f hex

# Create a temporal 64x64 PNG file with the colour in /tmp using convert
convert -size 64x64 xc:"$(wl-paste)" /tmp/colour.png

# Send a notification using the file as an icon
notify-send "colour picked" "$(wl-paste)" -i /tmp/colour.png

# Remove the temporal file
rm /tmp/colour.png

# Exit
exit 0