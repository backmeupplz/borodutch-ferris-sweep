# ferris-sweep

Ferris Sweep keyboard layout manager — edit layers from CLI, generate QMK firmware, and pop up a cheat sheet in Omarchy.

## Layout

**Base:** Colemak-DH with Home Row Mods (GACS order: Super/Alt/Ctrl/Shift)  
**5 layers:** BASE → NAV → SYM → NUM → MED  
**Optimised for:** Neovim/LazyVim · AI prompt writing · Hyprland/Omarchy shortcuts

```
BASE — Colemak-DH + HRM
  Q    W    F    P    B  ┃  J    L    U    Y    '
 [A]  [R]  [S]  [T]  G  ┃  M   [N]  [E]  [I]  [O]
  Z    X    C    D    V  ┃  K    H    ,    .    /
              Tab  Spc   ┃  Ent  Bsp
              MED  NAV   ┃  SYM  NUM

[X] = Home Row Mod: A=Super  R=Alt  S=Ctrl  T=Shift (mirrored on right)
```

## Install

```bash
./install.sh
```

This will:
1. Symlink `sweep` to `~/.local/bin/sweep`
2. Generate `keymap/` QMK files
3. Add floating window rules + `Super+Shift+K` keybinding to Hyprland

## Usage

```bash
sweep list                      # list all layers
sweep show                      # show all layers
sweep show BASE                 # show a specific layer
sweep show 2                    # show layer by index
sweep combos                    # show all combos

sweep set BASE 1 0 LGUI_T(KC_A) # set row 1, col 0 on BASE layer
sweep set NAV 0 5 KC_PGUP       # set top-right on NAV layer
# ROW: 0=top  1=home  2=bottom  3=thumbs
# COL: 0-9 for alpha rows, 0-3 for thumb row

sweep generate                  # regenerate keymap/ from layout.json
sweep flash                     # compile + flash (requires: yay -S qmk)
sweep cheatsheet                # full cheat sheet (also: Super+Shift+K popup)
sweep info                      # project info + keyboard detection
```

## Editing the layout

Edit `layout.json` directly or use `sweep set`. After any change:

```bash
sweep generate   # regenerates keymap/keymap.c, config.h, rules.mk
```

Then flash with QMK:

```bash
yay -S qmk
qmk setup        # first time only
sweep flash
```

## Layer map

| Thumb hold | Layer | Purpose |
|-----------|-------|---------|
| Spc (inner L) | NAV | vi-arrows, Page/Home/End, nav modifiers |
| Ent (inner R) | SYM | All symbols — brackets paired, ESC top-left |
| Bsp (outer R) | NUM | Numbers (odd L, even R) + F-keys |
| Tab (outer L) | MED | Media, RGB, system (QK_BOOT for flashing) |
| NAV + SYM | NUM | Tri-layer shortcut |

## Key combos

| Combo | Result | Notes |
|-------|--------|-------|
| J + K | Esc | Neovim normal mode |
| N + M | : | Neovim command mode |
| U + I | Del | |
| L + ' | Caps Word | Smarter caps lock |
| D + F | Tab | Left-hand-only tab |
| Shift + , | ; | Key override |
| Shift + . | : | Key override |

## Cheat sheet popup

`Super + Shift + K` opens a floating ghostty window with the full cheat sheet.

To close: `q` or `Ctrl+C`.

## Files

```
layout.json     ← source of truth (edit this)
sweep           ← CLI tool
keymap/
  keymap.c      ← auto-generated (do not edit directly)
  config.h      ← auto-generated
  rules.mk      ← auto-generated
install.sh      ← one-time setup
```
