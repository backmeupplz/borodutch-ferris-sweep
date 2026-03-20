# Borodutch Ferris Sweep

⚠️ **AI Agent Note**: This repository is designed as a starting point for AI assistants. Don't clone this directly — give it to Claude/Cursor along with your customization requests.

Custom firmware for the HolyKeebs Sweeq (Ferris Sweep variant) split keyboard with trackpoint support. Built with a 6-layer Miryoku-inspired Colemak layout and VIA runtime configuration.

## What's Included

- **Keyboard**: HolyKeebs Sweeq (Ferris Sweep with integrated trackpoint)
- **Layout**: 6-layer Colemak (QWERTY scancodes + OS-level Colemak remap)
- **Trackpoint**: Full support via holykeebs firmware (`HK_D_MODE` for drag-scroll)
- **VIA Enabled**: Edit keymaps in browser at https://usevia.app without reflashing
- **Flash Script**: Simple `./sweep flash` command for both halves
- **Home Row Mods**: GACS order (Super/Alt/Ctrl/Shift) on both hands
- **Combos**: N+E (JK on QWERTY) → Escape, Z+/ → Caps Word

## Quick Start

### 1. Clone with submodules
```bash
git clone --recurse-submodules https://github.com/backmeupplz/borodutch-ferris-sweep.git
cd borodutch-ferris-sweep
```

If you already cloned without submodules:
```bash
git submodule update --init --recursive
```

### 2. Flash both halves

**Right half:**
```bash
./sweep flash
```
Put right half in bootloader mode (double-tap reset button).

**Left half:**
```bash
./sweep flash
```
Put left half in bootloader mode.

## Layout Overview

| Layer | Purpose | Access |
|-------|---------|--------|
| **BASE** | Colemak-DH with HRM | Default |
| **NAV** | Arrows, Home/End, PgUp/PgDn | Hold inner-left thumb (Spc) |
| **SYM** | Brackets, symbols (`{}[]!@#$%^&*()`) | Hold inner-right thumb (Ent) |
| **NUM** | Numpad + F-keys + Russian extras (Х Ъ Э Ё Ж) | Hold outer-right thumb (Bsp) |
| **MOUSE** | Trackpoint controls, drag-scroll | Hold outer-left thumb (Tab) |
| **SYSTEM** | Bootloader, reset | Combo: both inner thumbs |

**Combos:**
- **N+E** (right home row index+middle) → Escape (for Vim)
- **Both inner thumbs** → SYSTEM layer
- **Z+/** (bottom row outer columns) → Caps Word

## Editing the Layout

### Option 1: VIA (Recommended for quick changes)
1. Go to https://usevia.app
2. Connect keyboard via USB
3. Select your keyboard from the device list
4. Edit keymaps in the visual editor — changes persist to EEPROM

### Option 2: Edit layout.json
1. Modify `layout.json` (JSON format, human-readable layer definitions)
2. Run `./sweep generate` to update QMK files
3. Run `./sweep flash` to apply changes

## Prerequisites

- Python 3 (for `sweep` script)
- `arm-none-eabi-gcc` (Arch: `yay -S arm-none-eabi-gcc`)
- `udisksctl` (optional, for auto-mounting RPI-RP2 bootloader drive)

## Available Commands

```bash
./sweep list                      # List all layers
./sweep show [LAYER]              # Show layer diagram(s)
./sweep set LAYER ROW COL KEY     # Set a specific key
./sweep combos                    # Show all combos
./sweep generate                  # Regenerate QMK files from layout.json
./sweep flash                     # Compile + flash firmware
./sweep cheatsheet                # Full cheat sheet (scrollable)
./sweep info                      # Project info
```

## Architecture

```
layout.json          ← Source of truth (edit this)
sweep                ← Python CLI tool
keymap/              ← Auto-generated QMK files
  ├── keymap.c       ← Layer definitions
  ├── config.h       ← Tapping term, combo settings
  └── rules.mk       ← Build configuration (VIA, combos, etc.)
qmk_firmware/        ← HolyKeebs QMK fork (submodule, hk-master branch)
  └── keyboards/holykeebs/sweeq/keymaps/sweeq/  ← Copied during flash
```

## Why Self-Contained?

This repo includes the QMK firmware as a shallow submodule (`qmk_firmware/`). This ensures:
- **Portability**: Works on any machine without external QMK installation
- **Reproducibility**: Locked to specific holykeebs commit
- **Simplicity**: Single command (`./sweep flash`) does everything

## Omarchy Integration

This layout is designed for use with [Omarchy](https://github.com/omarchy93/omarchy) Linux desktop:
- Colemak keyboard variant in OS settings
- `sweep cheatsheet` command bound to `Super+Shift+K` popup
- Hyprland window rules for floating cheat sheet

## Credits

- **Hardware**: [HolyKeebs Sweeq](https://holykeebs.com)
- **Firmware Base**: [holykeebs/qmk_firmware](https://github.com/holykeebs/qmk_firmware) (hk-master branch)
- **Layout Philosophy**: [Miryoku](https://github.com/manna-harbour/miryoku)
- **Inspiration**: Ferris Sweep minimalism

## License

GPL-2.0+ (same as QMK firmware)
