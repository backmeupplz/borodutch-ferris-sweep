# Ferris Sweep (Sweeq) — AI Agent Reference

> Quick reference for AI agents working with this keyboard firmware repository.

## 🎯 One-Line Summary

Custom QMK firmware for HolyKeebs Sweeq (Ferris Sweep with trackpoint), 6-layer Miryoku-inspired Colemak layout, VIA-enabled, fully self-contained with embedded QMK submodule.

## ⚡ Most Common Tasks

### Flash the Keyboard (Do This First)
```bash
cd /home/borodutch/code/borodutch-ferris-sweep
./sweep flash  # Right half (user puts in bootloader mode)
./sweep flash  # Left half (user puts in bootloader mode)
```

### Quick Layout Change (VIA - No Flashing)
Tell user: "Go to https://usevia.app, connect your keyboard, edit visually."

### Structural Change (Edit layout.json)
```bash
# Edit layout.json with new keycodes
./sweep generate  # Regenerates keymap/keymap.c, config.h, rules.mk
./sweep flash     # Flash both halves
```

## 🏗️ Architecture

**Physical → QMK → OS**
- **Physical:** QWERTY key positions
- **QMK Sends:** QWERTY scancodes (A key sends `KC_A`)
- **OS Remaps:** Hyprland `kb_variant = colemak` → Colemak layout
- **Result:** User sees Colemak, keyboard sends QWERTY

**Right Half = Master**
- Contains trackpoint
- Plugs into USB
- LEFT half connects via TRRS cable (never disconnect while powered!)

## 📂 File Structure

```
/home/borodutch/code/borodutch-ferris-sweep/
├── AGENTS.md           ← READ THIS for AI instructions
├── layout.json         ← EDIT THIS for layout changes
├── sweep               ← Python CLI tool
├── keymap/             ← Auto-generated (./sweep generate)
│   ├── keymap.c
│   ├── config.h
│   └── rules.mk
├── qmk_firmware/       ← HolyKeebs QMK submodule (hk-master)
│   └── keyboards/holykeebs/sweeq/keymaps/sweeq/ ← Copied during flash
├── README.md           ← User documentation
└── LICENSE             ← GPL-2.0+
```

## 🎹 Layout Reference

| Layer | Access | Purpose |
|-------|--------|---------|
| BASE | Default | Colemak-DH + GACS home row mods |
| NAV | Hold inner-left (Spc) | Arrows, Home/End, PgUp/PgDn |
| SYM | Hold inner-right (Ent) | Symbols `!@#$%^&*()[]{}` |
| NUM | Hold outer-right (Bsp) | Numpad, F-keys, Russian extras |
| MOUSE | Hold outer-left (Tab) | Trackpoint, drag-scroll |
| SYSTEM | Combo (Bsp+Spc) | Bootloader, reset |

**Combos:**
- N+E → Escape (Vim normal mode)
- Z+/ → Caps Word

## 🔑 Keycode Quick Reference

| Pattern | Example | Meaning |
|---------|---------|---------|
| `KC_XX` | `KC_A`, `KC_ENT` | Regular key |
| `L/RXX_T(KC)` | `LGUI_T(KC_A)` | Home row mod (Left GUI tap/hold) |
| `LT(LAYER,KC)` | `LT(NAV,KC_SPC)` | Layer-tap: tap=KC, hold=LAYER |
| `S(KC)` | `S(KC_P)` | Shifted (e.g., `:` in Colemak) |
| `XXXXXXX` | — | No key (empty) |
| `_______` | — | Transparent (falls through) |
| Special | `HK_D_MODE` | Drag-scroll mode |
| Special | `MS_BTN1` | Mouse button |

## 🛠️ Commands

```bash
./sweep list                 # List all layers
./sweep show [LAYER]         # Show layer diagram
./sweep set LAYER R C KEY    # Set key at row R, col C
./sweep combos               # Show combos
./sweep generate             # Regenerate QMK files
./sweep flash                # Compile + flash firmware
./sweep cheatsheet           # Full visual cheat sheet
./sweep info                 # Project info
```

## 🚫 Common Mistakes to Avoid

1. **Don't flash just one half** — Always flash BOTH halves separately
2. **Don't use ferris/sweep target** — Use `holykeebs/sweeq` only
3. **Don't disconnect TRRS while powered** — Will short GPIO pins
4. **Don't forget to generate** — Edit layout.json → `./sweep generate` → `./sweep flash`
5. **Don't reference ~/qmk_firmware** — Use `./qmk_firmware/` submodule

## 🔗 Essential Resources

- **VIA Editor:** https://usevia.app (for runtime keymap changes)
- **AGENTS.md:** `/home/borodutch/code/borodutch-ferris-sweep/AGENTS.md` (detailed AI instructions)
- **QMK Docs:** https://docs.qmk.fm
- **HolyKeebs QMK:** https://github.com/holykeebs/qmk_firmware (hk-master branch)

## 📝 Layout.json Format

```json
{
  "meta": { "keyboard": "holykeebs/sweeq", "layout_macro": "LAYOUT_split_3x5_2" },
  "config": { "tapping_term": 200, "quick_tap_term": 0, "combo_term": 50 },
  "layers": [
    {
      "name": "LAYER_NAME",
      "description": "What this layer does",
      "rows": [
        ["KC_Q", "KC_W", "KC_E", "KC_R", "KC_T",   "KC_Y", "KC_U", "KC_I", "KC_O", "KC_P"],
        ["LGUI_T(KC_A)", "LALT_T(KC_S)", ...],  // home row
        ["KC_Z", "KC_X", "KC_C", "KC_V", "KC_B",   "KC_N", "KC_M", "KC_COMM", "KC_DOT", "KC_SLSH"],
        ["LT(MOUSE,KC_TAB)", "LT(NAV,KC_BSPC)", "LT(SYM,KC_SPC)", "LT(NUM,KC_ENT)"]
      ]
    }
  ],
  "combos": [
    { "name": "jk_esc", "keys": ["RSFT_T(KC_J)", "RCTL_T(KC_K)"], "result": "KC_ESC" }
  ]
}
```

## 💡 AI Agent Workflow

1. **User asks about layout:** → Suggest VIA for quick changes
2. **User wants to modify:** → Edit `layout.json` → `./sweep generate`
3. **User wants to apply:** → `./sweep flash` (remind: both halves!)
4. **Something not working:** → Check `./sweep show` output, verify keycodes

---

**Repository:** https://github.com/backmeupplz/borodutch-ferris-sweep  
**Last Updated:** March 2026  
**See Also:** `AGENTS.md` for detailed flashing and troubleshooting guide
