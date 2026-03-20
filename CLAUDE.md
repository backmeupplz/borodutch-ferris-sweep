# Ferris Sweep — Sweeq Layout Manager

## What this is
CLI tool (`sweep`) for managing a Ferris Sweep keyboard layout ("Sweeq" — Miryoku-inspired Colemak). Source of truth is `layout.json`; QMK keymap files are generated from it.

## Architecture: QWERTY scancodes + OS Colemak
The keyboard sends **QWERTY scancodes** via QMK. Hyprland's `kb_variant = colemak` remaps letters to Colemak at the OS level. Symbols/numbers are NOT remapped by Colemak. The `sweep` CLI displays **Colemak output** (not raw QWERTY keycodes).

Russian ЙЦУКЕН maps to QWERTY physical positions via OS, so it works automatically. Extra Russian chars (Х Ъ Э Ё Ж) are on NUM/SYM layers via `[ ] ' \` ;` keycodes.

## Key commands
```bash
sweep cheatsheet          # view all layers + combos
sweep show [LAYER]        # show one or all layers
sweep list                # list layers
sweep set LAYER ROW COL KEY  # set a key (ROW: 0=top 1=home 2=bottom 3=thumbs, COL: 0-9 alpha / 0-3 thumbs)
sweep combos              # show combos
sweep generate            # regenerate keymap/ from layout.json
sweep flash               # compile + flash (needs qmk)
```

## Editing the layout
- Edit `layout.json` directly or use `sweep set`
- After changes: run `sweep generate` to update `keymap/keymap.c`, `config.h`, `rules.mk`
- Keys use QMK keycodes: `KC_A`, `LGUI_T(KC_A)` (home row mod), `LT(NAV,KC_SPC)` (layer-tap)
- Use `S(KC_P)` for shifted keycodes (e.g., `:` in Colemak = Shift + QWERTY P scancode)

## Flashing
Uses **holykeebs QMK fork** (`hk-master` branch). Keyboard target is `holykeebs/sweeq` (NOT `ferris/sweep` or `idank/sweeq`).
```bash
sweep generate                  # regenerate keymap files
sweep flash                     # compile + flash with trackpoint support
# Or manually:
make holykeebs/sweeq:sweeq:flash -e USER_NAME=holykeebs -e POINTING_DEVICE=trackpoint -e POINTING_DEVICE_POSITION=right -j8
```
- **Both halves** must be flashed separately with the same firmware
- Right half = master (has trackpoint, plugged into USB). Board defines `MASTER_RIGHT`.
- Never disconnect TRRS cable while powered
- QMK repo: `~/qmk_firmware` on branch `holykeebs/hk-master`
- Keymap symlinked: `~/qmk_firmware/keyboards/holykeebs/sweeq/keymaps/sweeq -> keymap/`
- No CONVERT_TO needed (board natively targets RP2040)

## File structure
- `layout.json` — source of truth (edit this)
- `sweep` — Python CLI tool
- `keymap/` — auto-generated QMK files (do not edit directly)
- `install.sh` — one-time setup (symlinks, Hyprland config)

## Current layout
6 layers: BASE (Colemak via OS, GACS home row mods), NAV (arrows/Home/End), SYM (shifted symbols), NUM (numpad/F-keys), MOUSE (trackpoint buttons/scroll), SYSTEM (boot).

Combos:
- N+E (right home index+middle) → Escape (for Vim)
- Both inner thumbs (Bsp+Spc) → SYSTEM layer
- Z+/ (bottom row corners) → Caps Word
