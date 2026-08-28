# 🖤 OLED Monochrome Design System

> [!NOTE]
> Flint adheres to a **Strict OLED Monochrome Design System**: True Black (`#000000`), Chrome White (`#ffffff`), and Crisp Silver (`#a3a3a3`) with 0-radius square brutalist geometry across all desktop, terminal, and IDE components.

---

## 🎨 Color Tokens & Palette

| Token | Hex | Usage |
| :--- | :--- | :--- |
| **`background`** | `#000000` | Pure OLED True Black for terminals, panels, and backgrounds |
| **`background-alt`** | `#141414` | Subtle dark contrast for search inputs and card backgrounds |
| **`foreground`** | `#ffffff` | Primary text, focused borders, active indicators |
| **`secondary`** | `#a3a3a3` | Muted labels, secondary text, inactive indicators |
| **`border-col`** | `#262626` | Sharp 1px/2px container borders |
| **`alert`** | `#ef4444` | Errors, critical battery warnings, urgent notifications |
| **`success`** | `#22c55e` | GameMode active, confirmed states |

---

## 🚀 Desktop Shortcuts & Switchers

| Shortcut | Action | Description |
| :--- | :--- | :--- |
| `SUPER + T` | **Wallpaper Switcher** | Visual Rofi grid with live thumbnails; transitions instantly via `awww`. |
| `SUPER + A` | **Animation Switcher** | Live preset switcher: `fluid`, `snappy`, `bouncy`, `subtle`, or `disabled`. |
| `SUPER + /` | **Keybindings Cheatsheet** | Live parser reading active keybindings directly from `bindings.lua`. |
| `SUPER + P` | **Flint Packages Explorer** | Interactive TUI (`flint-pkgs`) searching all installed and available tools. |
| `SUPER + N` | **Night Light Toggle** | Toggles color temperature (4200K / 6500K) via `hyprsunset`. |
| `SUPER + G` | **Game Mode Toggle** | Disables blur, shadows, and animations for max FPS. |

---

## 🖼️ Wallpaper Management

Place `.jpg`, `.png`, `.webp`, or `.gif` files into:
- `~/.config/flint/wallpapers/` (version-controlled alongside your configuration)
- `~/Pictures/Wallpapers/` (local user wallpapers directory)

> [!TIP]
> Press `SUPER + T` after adding wallpapers. The switcher reads both directories automatically.

---

## 📐 Unified Geometry & Applications

Every component is styled with strict 0-radius corners (`border-radius: 0 !important`):

1. **Hyprland**: 0 rounding, 1px borders, disabled xray compositing for stutter-free performance.
2. **Waybar**: Flat monochrome top bar with status pills and workspace glyphs.
3. **Dunst**: Sharp square notification cards with high-contrast urgency borders.
4. **Rofi**: 0-radius launcher, powermenu, wallpaper picker, and clipboard manager.
5. **GTK 3 & 4**: Universal `border-radius: 0 !important` override across all Libadwaita and GTK widgets.
6. **SwayOSD**: Minimal volume and brightness on-screen display HUD.
7. **NVF (Neovim)**: Curated `mini.base16` OLED monochrome palette with true `#000000` background.
8. **Kitty**: Monochrome color scheme with transparent OLED black backdrop.
9. **Yazi & Btop**: Synchronized monochrome themes.
