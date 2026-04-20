#!/bin/bash

PRESET=$1

if [ -z "$PRESET" ]; then
    echo "Usage: ./switch_mango.sh style1"
    exit 1
fi

PRESET_PATH="$HOME/.config/mango_presets/$PRESET"

# --- 1. Wallpaper wechseln (swww) ---
# Wir suchen nach einer Datei, die 'wallpaper' oder 'bg' heißt (jpg, png oder webp)
WP=$(find "$PRESET_PATH" -maxdepth 1 -type f \( -name "wallpaper.*" -o -name "bg.*" \) | head -n 1)

# Wallpaper als current_wallpaper.jpg in ~/Bilder speichern (überschreibt vorheriges, immer JPG)
magick "$WP" "$HOME/Bilder/current_wallpaper.jpg"

awww img "$HOME/Bilder/current_wallpaper.jpg"

# --- 2. Mango & Waybar Configs kopieren ---
cp "$PRESET_PATH/config.conf" "$HOME/.config/mango/config.conf"
cp "$PRESET_PATH/waybar/config.jsonc" "$HOME/.config/waybar/config.jsonc"
cp "$PRESET_PATH/waybar/style.css" "$HOME/.config/waybar/style.css"

# --- 3. Wofi Configs kopieren (falls vorhanden) ---
if [ -d "$PRESET_PATH/wofi" ]; then
    cp "$PRESET_PATH/wofi/config" "$HOME/.config/wofi/config"
    cp "$PRESET_PATH/wofi/style.css" "$HOME/.config/wofi/style.css"
fi

# --- 4. Reload everything ---


pkill waybar
waybar

