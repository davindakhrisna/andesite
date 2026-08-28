# 🔧 Troubleshooting & FAQ

> [!NOTE]
> Solutions and diagnostic one-liners for common desktop, display, audio, and performance scenarios.

---

## ❓ Frequently Encountered Scenarios

### 1. Hyprland Stuttering or Frame Drops
If experiencing frame pacing issues or stutter:
1. **Disable Blur X-Ray**: Ensure `xray = false` in `hyprland.lua` (xray performs an expensive extra compositing pass).
2. **Set Inactive Opacity to 1.0**: Setting `inactive_opacity = 1.0` avoids running blur passes on background windows.
3. **Verify VA-API Hardware Video Acceleration**: Run `vainfo` to confirm `nvidia-vaapi-driver` is handling video decoding.
4. **Use Game Mode**: Press `SUPER + G` to instantly disable all animations, blur, and decorative gaps.

> [!TIP]
> Ensure your Btrfs root filesystem uses `noatime,compress=zstd,discard=async` mount options in `_hardware.nix` and reboot to apply.

---

### 2. Multi-Monitor Display Arrangement
If monitors are misaligned or a new display was connected:
```bash
# Trigger the interactive layout selector (Extend Right/Left, Mirror, External Only)
auto-monitor.sh
```
Or launch the monitor layout TUI:
```bash
hyprmon
```

---

### 3. Audio Output or Microphone Device Selection
PipeWire and WirePlumber manage audio routing. If sound is routed to the wrong device:
```bash
# Launch PipeWire interactive mixer
wiremix
```
Or toggle mute directly:
- **Audio Output**: `SUPER + bindings` or `XF86AudioMute`
- **Microphone Input**: `XF86AudioMicMute`

---

### 4. Force Reloading GTK Applications
To apply modified `gtk.css` rules (`border-radius: 0 !important` or color overrides):
```bash
# Restart running GTK application (e.g. Thunar)
pkill -x thunar && thunar &
```

---

### 5. Cleaning Disk Space & Old Nix Generations
```bash
# Remove all old system & user generations, keeping only the 3 most recent
nh clean all --keep 3
```

---

### 6. Testing Changes Safely Before Booting
```bash
# Test changes in memory without creating a bootloader entry
nh os test
# (or short alias)
not
```
