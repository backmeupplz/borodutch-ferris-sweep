# For AI Agents: Ferris Sweep (Sweeq) Keyboard

> **QUICK REFERENCE FOR AI AGENTS** — This file tells you everything you need to know to help flash and modify this keyboard.

## ⚡ Flashing Instructions (Most Common Task)

**Prerequisites:**
- Repository is at `/home/borodutch/code/borodutch-ferris-sweep`
- QMK submodule is at `./qmk_firmware/` (initialized with `git submodule update --init --recursive`)
- Flash script: `./sweep flash`

**To flash the keyboard:**

1. **Flash right half:**
   ```bash
   cd /home/borodutch/code/borodutch-ferris-sweep
   ./sweep flash
   ```
   User will put the right half in bootloader mode (double-tap reset button).

2. **Flash left half:**
   ```bash
   ./sweep flash
   ```
   User will put the left half in bootloader mode.

**What happens during flash:**
1. Generates keymap files from `layout.json` into `./keymap/`
2. Copies files to `./qmk_firmware/keyboards/holykeebs/sweeq/keymaps/sweeq/`
3. Compiles firmware with holykeebs settings (trackpoint support)
4. Flashes to the RP2040 bootloader drive

**Important:** Both halves MUST be flashed separately with the same firmware.

---

## 🎹 Keyboard Architecture

**Hardware:** HolyKeebs Sweeq (Ferris Sweep variant with trackpoint)
- **Right half = Master** (has trackpoint, plugs into USB)
- **Layout:** 6-layer Miryoku-inspired Colemak
- **Scancodes:** QWERTY (OS-level Colemak remap via Hyprland `kb_variant = colemak`)
- **VIA:** Enabled — use https://usevia.app for runtime keymap editing

**Layers:**
1. **BASE** — Colemak-DH with GACS home row mods (Super/Alt/Ctrl/Shift)
2. **NAV** — Arrows, Home/End, PgUp/PgDn (hold inner-left thumb)
3. **SYM** — Symbols and brackets (hold inner-right thumb)
4. **NUM** — Numpad + F-keys + Russian extras (Х Ъ Э Ё Ж) (hold outer-right thumb)
5. **MOUSE** — Trackpoint controls, drag-scroll (hold outer-left thumb)
6. **SYSTEM** — Bootloader access (combo: both inner thumbs)

**Combos:**
- N+E (right home row) → Escape (for Vim)
- Z+/ (bottom corners) → Caps Word

---

## 📝 Modifying the Layout

### Option 1: VIA (Easiest)
Tell user to go to https://usevia.app in browser and edit keymaps visually. Changes persist to EEPROM.

### Option 2: Edit layout.json
**File:** `layout.json` (human-readable JSON)

**Common modifications:**

1. **Change a key on a layer:**
   Edit the appropriate row/col in the layer's `"rows"` array.
   
2. **Keycode format:**
   - Regular key: `KC_A`, `KC_ENT`, `KC_TAB`
   - Home row mod: `LGUI_T(KC_A)`, `LALT_T(KC_S)`, `LCTL_T(KC_D)`, `LSFT_T(KC_F)`
   - Layer-tap: `LT(NAV,KC_SPC)`, `LT(SYM,KC_ENT)`
   - Shifted: `S(KC_P)` for colon in Colemak
   - Special: `HK_D_MODE` (drag-scroll), `MS_BTN1` (mouse button)
   - Transparent: `_______` or `KC_TRNS`
   - Empty/None: `XXXXXXX`

3. **After editing layout.json:**
   ```bash
   ./sweep generate  # Regenerates keymap/keymap.c, config.h, rules.mk
   ./sweep flash     # Flash to keyboard
   ```

---

## 🔧 Available Commands

```bash
./sweep list                      # List all layers
./sweep show [LAYER]              # Show layer diagram (e.g., ./sweep show BASE)
./sweep set LAYER ROW COL KEY     # Set specific key
./sweep combos                    # Show all combos
./sweep generate                  # Regenerate QMK files from layout.json
./sweep flash                     # Compile + flash firmware
./sweep cheatsheet                # Full scrollable cheat sheet
./sweep info                      # Project info
```

---

## 🚨 Important Rules

1. **Always flash both halves** — They need the same firmware to communicate
2. **Never disconnect TRRS cable while powered** — Can short GPIO pins
3. **Right half is master** — Always plug USB into right half
4. **Use holykeebs/sweeq target** — NOT ferris/sweep or other variants
5. **QWERTY scancodes** — OS remaps to Colemak, so use QWERTY positions

---

## 📁 File Structure

```
/home/borodutch/code/borodutch-ferris-sweep/
├── layout.json              ← EDIT THIS for layout changes
├── sweep                    ← Python CLI tool (executable)
├── keymap/                  ← Auto-generated (sweep generate)
│   ├── keymap.c
│   ├── config.h
│   └── rules.mk
├── qmk_firmware/            ← HolyKeebs QMK submodule (hk-master branch)
│   └── keyboards/holykeebs/sweeq/keymaps/sweeq/  ← Copied during flash
├── README.md                ← User documentation
├── LICENSE                  ← GPL-2.0+
└── .gitmodules              ← Tracks QMK submodule
```

---

## 🐛 Troubleshooting

**Flash fails:**
- Check if keyboard is in bootloader mode (RPI-RP2 drive should appear)
- Ensure QMK submodule is initialized: `git submodule update --init --recursive`
- Verify right half is master (trackpoint side)

**Layout not updating:**
- Must run `./sweep generate` after editing layout.json
- Must flash both halves for changes to sync

**Key not working:**
- Check if using correct keycode format
- Verify layer access method (layer-tap vs combo)
- Use VIA to test if it's a firmware or layout issue

---

## 🔗 Useful Resources

- **VIA Web Editor:** https://usevia.app
- **QMK Keycodes:** https://docs.qmk.fm/#/keycodes
- **HolyKeebs QMK:** https://github.com/holykeebs/qmk_firmware (hk-master branch)
- **Layout visualizer:** `./sweep show` or `./sweep cheatsheet`

---

## 💡 For AI Agents

When user asks about this keyboard:
1. **Default to VIA** for quick changes (no flashing needed)
2. **Use layout.json** for structural changes (new layers, combos, etc.)
3. **Always offer to flash** after modifications
4. **Remind about both halves** — they need separate flashing
5. **Check CLAUDE.md** for additional context

The user has Omarchy desktop with Hyprland, so the keyboard is remapped to Colemak at OS level. All physical layouts should be described in Colemak terms, not QWERTY.

---

**Last Updated:** March 2026
**Keyboard:** HolyKeebs Sweeq (Ferris Sweep with trackpoint)
**Firmware:** QMK with holykeebs extensions
**Repository:** https://github.com/backmeupplz/borodutch-ferris-sweep
