#!/usr/bin/env bash
# ==============================================================================
# Flint Desktop Keybindings Cheatsheet (Dynamic Real-time Rofi Parser)
# Automatically categorizes and extracts keybindings directly from bindings.lua
# ==============================================================================

# Export PATH with system profiles and user binaries
export PATH="/run/current-system/sw/bin:/etc/profiles/per-user/$USER/bin:$HOME/.nix-profile/bin:$PATH"

FLINT_DIR="${FLINT_DIR:-${HOME}/.config/flint}"
BINDINGS_LUA="${FLINT_DIR}/modules/home/desktop/config/hyprland/bindings.lua"

if [ ! -f "$BINDINGS_LUA" ]; then
    BINDINGS_LUA="${HOME}/.config/hypr/bindings.lua"
fi

if [ ! -f "$BINDINGS_LUA" ]; then
    rofi -e "Error: bindings.lua not found in $BINDINGS_LUA"
    exit 1
fi

# Dynamically parse bindings.lua via Python
FORMATTED_ENTRIES=$(python3 - << EOF
import re, sys

bindings_file = "$BINDINGS_LUA"
entries = []
seen = set()

with open(bindings_file, "r") as f:
    lines = f.readlines()

i = 0
while i < len(lines):
    line = lines[i].strip()
    i += 1
    
    # Detect section header
    if line.startswith("----------------------------------------") and i < len(lines):
        next_l = lines[i].strip()
        if next_l.startswith("-- "):
            sec_title = next_l.lstrip("- ").strip()
            entries.append((f"─── {sec_title} ───", ""))
            i += 1
            continue

    if not line or not line.startswith("hl.bind"):
        continue

    m = re.match(r"hl\.bind\((.+?),\s*(.+?)\)\s*(?:--\s*(.*))?$", line)
    if not m:
        continue

    raw_key = m.group(1).strip()
    raw_act = m.group(2).strip()
    comment = (m.group(3) or "").strip()

    # Workspace loop
    if "key" in raw_key:
        if "focus" in raw_act:
            k = "SUPER + 1 .. 10"
            d = "Switch to Workspace 1 through 10"
        else:
            k = "SUPER + Shift + 1 .. 10"
            d = "Move Window to Workspace 1 through 10"
        if k not in seen:
            seen.add(k)
            entries.append((k, d))
        continue

    # Mouse controls
    if "mouse:272" in raw_key:
        k = "SUPER + Left Mouse"
        d = "Drag / Move Window"
        if k not in seen:
            seen.add(k)
            entries.append((k, d))
        continue
    elif "mouse:273" in raw_key:
        k = "SUPER + Right Mouse"
        d = "Resize Window"
        if k not in seen:
            seen.add(k)
            entries.append((k, d))
        continue

    # Clean key string
    key = raw_key.replace("mainMod", "SUPER").replace("..", "").replace('"', '').replace("'", "").strip()
    key = re.sub(r"\s*\+\s*", " + ", key)
    key = key.replace("slash", "/").replace("period", ".").replace("comma", ",").replace("Return", "Enter")
    key = re.sub(r"\bshift\b", "Shift", key, flags=re.IGNORECASE)
    key = re.sub(r"\balt\b", "Alt", key, flags=re.IGNORECASE)

    # Determine description
    desc = comment
    if not desc:
        if "window.close" in raw_act: desc = "Close active window"
        elif "float" in raw_act: desc = "Toggle floating window mode"
        elif "fullscreen" in raw_act: desc = "Toggle fullscreen mode"
        elif "pseudo" in raw_act: desc = "Toggle pseudo-tiling mode"
        elif "togglesplit" in raw_act: desc = "Toggle split layout direction"
        elif "toggle_special" in raw_act: desc = "Toggle special scratchpad workspace"
        elif "special:magic" in raw_act: desc = "Move window to scratchpad"
        elif "focus" in raw_act and "direction" in raw_act:
            dm = re.search(r'direction\s*=\s*"(\w+)"', raw_act)
            desc = f"Move focus {dm.group(1).capitalize()}" if dm else "Move focus"
        elif "terminal" in raw_act: desc = "Launch Terminal Emulator (Kitty)"
        elif "helium" in raw_act: desc = "Launch Web Browser (Helium)"
        elif "spotify" in raw_act: desc = "Launch Spotify Music Player"
        elif "nvim" in raw_act: desc = "Launch Neovim IDE"
        elif "yazi" in raw_act: desc = "Launch Yazi File Manager"
        elif "obsidian" in raw_act: desc = "Launch Obsidian Notes"
        elif "vesktop" in raw_act: desc = "Launch Vesktop (Discord)"
        elif "lazygit" in raw_act: desc = "Launch Lazygit Git TUI"
        elif "flint-pkgs" in raw_act: desc = "Packages & Modules Explorer (Flint-Pkgs)"
        elif "clipboard.sh" in raw_act: desc = "Clipboard History (Cliphist + Rofi)"
        elif "screenshot.sh" in raw_act:
            if "region" in raw_act: desc = "Region Area Screenshot -> Satty"
            elif "full" in raw_act: desc = "Fullscreen Screenshot -> Satty"
            elif "window" in raw_act: desc = "Active Window Screenshot -> Satty"
            else: desc = "Take Screenshot"
        elif "wallpaper-switcher.sh" in raw_act: desc = "Wallpaper Switcher (Awww + Rofi)"
        elif "animation-switcher.sh" in raw_act: desc = "Animation Physics Switcher (Rofi)"
        elif "powermenu.sh" in raw_act: desc = "Session Power Menu (Lock/Shutdown)"
        elif "nightlight.sh" in raw_act: desc = "Night Light Toggle (Hyprsunset)"
        elif "gamemode.sh" in raw_act: desc = "Game Mode Toggle (Max FPS)"
        elif "keybindings-cheatsheet.sh" in raw_act: desc = "Keybindings Cheatsheet"
        elif "swayosd-client" in raw_act:
            if "raise" in raw_act: desc = "Volume Up (SwayOSD)"
            elif "lower" in raw_act: desc = "Volume Down (SwayOSD)"
            elif "mute-toggle" in raw_act and "output" in raw_act: desc = "Mute / Unmute Volume"
            elif "mute-toggle" in raw_act and "input" in raw_act: desc = "Mute / Unmute Microphone"
            elif "brightness raise" in raw_act: desc = "Brightness Up (SwayOSD)"
            elif "brightness lower" in raw_act: desc = "Brightness Down (SwayOSD)"
            else: desc = "SwayOSD Hardware Control"
        elif "playerctl" in raw_act:
            if "play-pause" in raw_act: desc = "Play / Pause Media"
            elif "next" in raw_act: desc = "Next Track"
            elif "previous" in raw_act: desc = "Previous Track"
            else: desc = "Media Player Control"
        else:
            desc = raw_act

    if key not in seen:
        seen.add(key)
        entries.append((key, desc))

for k, d in entries:
    if not d:
        print(f"\n{k}")
    else:
        print(f"  {k:<24} │ {d}")
EOF
)

# Show Rofi Menu
echo -e -n "$FORMATTED_ENTRIES" | rofi -dmenu \
    -p "Keybindings" \
    -mesg "Live Keybindings parsed from bindings.lua" \
    -theme-str '
    window {
        width: 780px;
    }
    listview {
        lines: 16;
    }
    '

exit 0
