# dotfiles

My personal dotfiles for a Wayland setup using **mango** (window manager), **waybar** (status bar), **wofi** (app launcher) and **swww/awww** (wallpaper daemon).

## Repo structure

```
dotfiles/
├── presets/          # Full desktop presets — bundle wallpaper + mango + waybar + wofi
│   ├── test/
│   └── xp/
├── standalone/       # Single-app configs that aren't part of a full preset
│   └── waybar/
│       └── black_basic/
├── scripts/          # Helper scripts
│   ├── mango_menu.sh
│   └── switch_mango.sh
└── README.md
```

### `presets/`

Each subfolder is a complete desktop look. A preset contains everything needed to switch the entire desktop in one command:

```
presets/<name>/
├── config.conf            # mango window manager config → ~/.config/mango/config.conf
├── wallpaper.{jpg,png,webp}  # background image
├── waybar/
│   ├── config.jsonc       # → ~/.config/waybar/config.jsonc
│   └── style.css          # → ~/.config/waybar/style.css
└── wofi/                  # optional
    ├── config             # → ~/.config/wofi/config
    └── style.css          # → ~/.config/wofi/style.css
```

The `wofi/` folder is optional — if missing, the active wofi config is left untouched.

### `standalone/`

Configs that aren't tied to a full preset — useful if you only want to grab a single waybar style, mango snippet, etc. without applying a whole desktop.

**Wallpapers belong in `presets/` only, never in `standalone/`.** Standalone configs are config files only.

### `scripts/`

- **`mango_menu.sh`** — Opens a wofi picker listing all preset names found in `~/.config/mango_presets/`. The chosen preset is passed to `switch_mango.sh`.
- **`switch_mango.sh <preset>`** — Applies a preset:
  1. Finds `wallpaper.*` (or `bg.*`) in the preset folder
  2. Converts it to `~/Bilder/current_wallpaper.jpg` with ImageMagick (always JPG, overwrites the previous one — useful for wofi backgrounds)
  3. Sets the wallpaper via `awww img`
  4. Copies the mango, waybar, and (if present) wofi configs into `~/.config/`
  5. Restarts waybar and reloads mango

## Usage

```bash
# Install presets so the scripts can find them
cp -r presets/* ~/.config/mango_presets/

# Make scripts executable and copy them to your home dir
chmod +x scripts/*.sh
cp scripts/*.sh ~/

# Switch directly
~/switch_mango.sh xp

# Or open the picker (bind this to a key in mango)
~/mango_menu.sh
```

## Adding a new preset

1. Create `~/.config/mango_presets/<your_name>/`
2. Drop in `config.conf`, `wallpaper.jpg`, `waybar/`, and optionally `wofi/`
3. Test with `~/switch_mango.sh <your_name>`
4. Copy it to `presets/` in this repo when you're happy with it

## Requirements

- [mango](https://github.com/DreamMaoMao/mango) — Wayland WM
- waybar
- wofi
- awww (or swww — adjust the script if you use vanilla swww)
- ImageMagick (`magick`) — for wallpaper format conversion
