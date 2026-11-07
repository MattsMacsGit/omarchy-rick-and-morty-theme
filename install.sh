#!/bin/bash
# Finish installing the Rick and Morty theme after `omarchy theme install`.
# Safe to run again; each step skips what is already done.
set -euo pipefail

THEME_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEME_SLUG="$(basename "$THEME_DIR")"
CLOCK_DIR="$HOME/.config/omarchy/plugins/${USER:-$(id -un)}.clock"

step() { printf '\n\033[1;32m==>\033[0m %s\n' "$*"; }

# 1. Omarchy ignores hyprland.lua (portal pop-ins, glow, frost) in any theme
#    that still has its .git folder. Removing it makes the theme your own copy.
step "Enabling the portal window effects"
rm -rf "$THEME_DIR/.git"

# 2. Short Stack is the credits-style font for the bar clock (SIL OFL).
step "Installing the Short Stack font"
mkdir -p "$HOME/.local/share/fonts"
cp "$THEME_DIR/fonts/ShortStack-Regular.ttf" "$HOME/.local/share/fonts/"
fc-cache -f "$HOME/.local/share/fonts" >/dev/null

# 3. Clone Omarchy's clock and teach it to read clock-font / clock-color.
#    Other themes have no such files, so the clock is unchanged on them.
step "Setting up the theme clock"
if [[ ! -d $CLOCK_DIR ]]; then
  omarchy plugin clone omarchy.clock
fi
python3 -I "$THEME_DIR/extras/patch-clock.py" "$CLOCK_DIR/BarWidget.qml" ||
  echo "Skipped the clock font; everything else is still installed."

# 4. Swap the OMARCHY screensaver for the theme's version while it is active.
step "Installing the screensaver hook"
omarchy hook install theme-set "$THEME_DIR/extras/20-theme-screensaver"

# 5. Only animate the wallpaper on an empty desktop (it is distracting behind
#    windows). Left alone if you already have your own wallpaper config.
step "Pausing the live wallpaper behind windows"
if [[ ! -f $HOME/.config/owe/config.toml ]]; then
  mkdir -p "$HOME/.config/owe"
  printf '[pause]\nfullscreen = true\noccupied_workspace = true\n' >"$HOME/.config/owe/config.toml"
  owe reload-config >/dev/null 2>&1 || true
else
  echo "Kept your existing ~/.config/owe/config.toml"
fi

# 6. Apply, and restart the shell so it sees the new font.
step "Applying the theme"
omarchy theme set "$THEME_SLUG"
omarchy restart shell >/dev/null 2>&1 || true

step "Done. Wubba lubba dub dub!"
