#!/usr/bin/env bash
# install.sh — set up ferris-sweep tooling on Omarchy/Arch Linux
set -e

PROJ="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SYMLINK="$HOME/.local/bin/sweep"
HYPR_CONF="$HOME/.config/hypr/ferris-sweep.conf"

echo ""
echo "  ferris-sweep install"
echo "  ─────────────────────────────────────────────"

# ── 1. Symlink sweep CLI ──────────────────────────────────────────────────────
mkdir -p "$HOME/.local/bin"
if [[ -L "$SYMLINK" ]]; then
    echo "  ✓ sweep already symlinked — updating"
    rm "$SYMLINK"
fi
ln -s "$PROJ/sweep" "$SYMLINK"
echo "  ✓ sweep → $SYMLINK"

# ── 2. Ensure ~/.local/bin is in PATH ─────────────────────────────────────────
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo ""
    echo "  ⚠  ~/.local/bin is not in PATH."
    echo "     Add this to ~/.bashrc / ~/.zshrc / ~/.profile:"
    echo "     export PATH=\"\$HOME/.local/bin:\$PATH\""
fi

# ── 3. Generate QMK files ─────────────────────────────────────────────────────
echo "  ✓ Generating QMK keymap files…"
python3 "$PROJ/sweep" generate

# ── 4. Install python-rich (optional, for prettier output) ───────────────────
if ! python3 -c "import rich" 2>/dev/null; then
    if command -v yay &>/dev/null && [[ -t 0 ]]; then
        echo ""
        read -r -p "  Install python-rich for prettier output? [Y/n] " yn
        if [[ "$yn" != n && "$yn" != N ]]; then
            yay -S --noconfirm python-rich
            echo "  ✓ python-rich installed"
        fi
    elif command -v yay &>/dev/null; then
        echo "  ℹ  Optional: run 'yay -S python-rich' for even prettier output"
    fi
fi

# ── 5. Hyprland window rule + keybinding ────────────────────────────────────
cat > "$HYPR_CONF" <<'HYPR'
# ferris-sweep cheat sheet — floating window
# Toggle with: Super + Shift + K

windowrule = float,        match:class sweep-cheatsheet
windowrule = size 880 650, match:class sweep-cheatsheet
windowrule = center,       match:class sweep-cheatsheet
windowrule = stayfocused,  match:class sweep-cheatsheet

# Keybinding — Super+Shift+K  (K = Keyboard)
bindd = SUPER SHIFT, K, Keyboard cheat sheet, exec, \
    ghostty --class=sweep-cheatsheet \
            --title="Ferris Sweep — Keyboard Layout" \
            -e sweep cheatsheet
HYPR

echo "  ✓ Hyprland config → $HYPR_CONF"

# ── 6. Source the hyprland config if not already included ────────────────────
HYPR_MAIN="$HOME/.config/hypr/hyprland.conf"
if [[ -f "$HYPR_MAIN" ]] && ! grep -q "ferris-sweep.conf" "$HYPR_MAIN"; then
    echo "" >> "$HYPR_MAIN"
    echo "source = $HYPR_CONF" >> "$HYPR_MAIN"
    echo "  ✓ Added source line to hyprland.conf"
else
    echo "  ✓ hyprland.conf already includes ferris-sweep.conf (or not found)"
fi

# ── 7. Reload Hyprland ────────────────────────────────────────────────────────
if command -v hyprctl &>/dev/null; then
    hyprctl reload 2>/dev/null && echo "  ✓ Hyprland reloaded" || true
fi

echo ""
echo "  Done! Try:"
echo ""
echo "    sweep list              # list all layers"
echo "    sweep show              # show all layers"
echo "    sweep show BASE         # show a specific layer"
echo "    sweep combos            # show combos"
echo "    sweep set BASE 0 0 KC_Q # edit a key"
echo "    sweep generate          # regenerate QMK files"
echo ""
echo "  Keyboard cheat sheet popup:"
echo "    Super + Shift + K       # open floating cheat sheet in Hyprland"
echo "    sweep cheatsheet        # show in current terminal"
echo ""
echo "  Flash firmware:"
echo "    yay -S qmk              # install QMK CLI first"
echo "    sweep flash             # compile + flash"
echo ""
