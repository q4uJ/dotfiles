#!/bin/bash

PRESET=$1

if [ -z "$PRESET" ]; then
    echo "Usage: ./save_mango.sh <preset_name>"
    exit 1
fi

PRESET_PATH="$HOME/.config/mango_presets/$PRESET"

if [ -d "$PRESET_PATH" ]; then
    read -p "Preset '$PRESET' already exists. Overwrite? [y/N] " ans
    case "$ans" in
        y|Y|yes|YES) ;;
        *) echo "Aborted."; exit 1 ;;
    esac
fi

mkdir -p "$PRESET_PATH/waybar" "$PRESET_PATH/wofi"

# --- 1. Wallpaper speichern ---
WP_SRC="$HOME/Bilder/current_wallpaper.jpg"
if [ -f "$WP_SRC" ]; then
    cp "$WP_SRC" "$PRESET_PATH/wallpaper.jpg"
else
    echo "Warning: $WP_SRC not found, skipping wallpaper."
fi

# --- 2. Mango & Waybar Configs kopieren ---
cp "$HOME/.config/mango/config.conf"     "$PRESET_PATH/config.conf"
cp "$HOME/.config/waybar/config.jsonc"   "$PRESET_PATH/waybar/config.jsonc"
cp "$HOME/.config/waybar/style.css"      "$PRESET_PATH/waybar/style.css"

# --- 3. Wofi Configs kopieren (falls vorhanden) ---
if [ -f "$HOME/.config/wofi/config" ]; then
    cp "$HOME/.config/wofi/config"    "$PRESET_PATH/wofi/config"
fi
if [ -f "$HOME/.config/wofi/style.css" ]; then
    cp "$HOME/.config/wofi/style.css" "$PRESET_PATH/wofi/style.css"
fi

echo "Preset '$PRESET' saved to $PRESET_PATH"
