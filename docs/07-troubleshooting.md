# 🔧 Troubleshooting & FAQ

> [!NOTE]
> Quick answers and terminal one-liners for common desktop scenarios.

---

## ❓ Frequently Asked Questions

### 1. `nh os switch` reports missing flake path
Ensure `NH_FLAKE` or `programs.nh.flake` is set:
```bash
# Explicit path switch
nh os switch ~/.config/flint
```

### 2. Git reports "dubious ownership in repository"
Git requires marking the config directory as safe:
```bash
git config --global --add safe.directory ~/.config/flint
```

### 3. Display / Multi-Monitor Not Arranged Properly
Run the interactive monitor detection wizard:
```bash
~/.config/flint/modules/home/desktop/config/hyprland/scripts/auto-monitor.sh
```
Or edit display rules in `~/.config/flint/modules/home/desktop/config/hyprland/hyprland.lua`.

### 4. Audio output or microphone not detected
Use the TUI audio mixer:
```bash
# Launch wiremix modal
wiremix
```

### 5. Cleaning Disk Space & Old Nix Generations
```bash
# Delete all non-current Nix generations
nh clean all --keep 3
```

---

> [!TIP]
> To test configuration changes without creating a GRUB/systemd-boot entry, use `nh os test` (or `not`).
