# 🎨 Dynamic Theming & Wallust Engine

> [!NOTE]
> Flint achieves **100% theme domination** using Wallust. Changing wallpapers dynamically recompiles color schemes across 18 system and desktop components.

---

## 🚀 Theming Shortcuts

| Keybinding | Action | Description |
| :--- | :--- | :--- |
| `SUPER + W` | **Wallpaper Grid** | Interactive Rofi grid with live visual image thumbnails. |
| `SUPER + T` | **Theme Switcher** | Select between Dark, Light, Soft Dark, or OLED Hard Dark. |
| `SUPER + A` | **Animation Switcher** | Select between `fluid`, `snappy`, `bouncy`, `subtle`, or `disabled`. |

---

## 🖼️ Adding Custom Wallpapers

Place `.jpg`, `.png`, `.webp`, or `.gif` files into either:
* `~/.config/flint/wallpapers/` (version-controlled alongside your config)
* `~/Pictures/Wallpapers/` (local user directory)

> [!TIP]
> Press `SUPER + W` right after adding images—the thumbnail grid populates automatically.

---

## 🎯 Supported Application Targets

Wallust automatically extracts and synchronizes colors for:
1. **Hyprland** (`colors.lua` - dynamic border gradient)
2. **Waybar** (`colors-waybar.css` - top bar accent colors)
3. **Dunst** (`dunstrc` - notification colors)
4. **Rofi** (`colors-rofi.rasi` - launcher, powermenu, cliphist)
5. **Kitty** (`colors-kitty.conf` - 16 ANSI palette)
6. **GTK 3 / 4** (`gtk.css` - desktop app palettes)
7. **SwayOSD** (`colors-swayosd.css` - volume & brightness HUD)
8. **Neovim / NVF** (`colors-neovim.lua` - `mini.base16` colors)
9. **Btop** (`wallust.theme` - system monitor)
10. **Yazi** (`theme.toml` - file manager)
11. **Cava** (`config` - audio visualizer)
12. **FZF / Shell** (`colors-fzf.zsh` - fuzzy search highlighting)
13. **Hyprlock** (`colors-hyprlock.conf` - lockscreen accents)
