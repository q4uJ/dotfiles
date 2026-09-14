#!/bin/bash
# Get list of presets from the folder names
CHOICE=$(ls ~/.config/mango_presets | wofi --show dmenu --prompt "Choose Desktop Style")

if [ -n "$CHOICE" ]; then
    ~/switch_mango.sh "$CHOICE"
fi
