# Flint

> Multi-host NixOS & Home Manager configuration with a clean dendritic architecture powered by `flake-parts` and `import-tree`.

---

## 🏛️ Architecture Overview

Flint is organized into modular layers where modules are automatically discovered and imported by `import-tree`:

```
.
├── flake.nix                  # Flake inputs, flake-parts orchestration, and module exports
├── hosts/                     # Host-specific configurations and hardware definitions
│   ├── powerhouse/            # Main workstation (Intel CPU + Nvidia GPU, Btrfs)
│   └── template/              # Boilerplate configuration for new machines
└── modules/                   # Reusable system and user modules
    ├── system/                # NixOS system-level modules (`flake.nixosModules`)
    │   ├── base.nix           # Kernel hardening, audio (PipeWire), Docker, Nix settings
    │   ├── desktop.nix        # Hyprland (UWSM), Ly display manager, fonts
    │   ├── gaming.nix         # Steam, GameMode, Gamescope
    │   ├── hardware.nix       # CPU/GPU options (`intel`, `amd`, `nvidia`)
    │   └── utils.nix          # System packages & Chromium fallback
    └── home/                  # Home Manager user modules (`flake.homeModules`)
        ├── home.nix           # GTK, Qt, cursor, XDG paths, environment variables
        ├── desktop/           # Desktop packages, Kanshi, Helium browser
        ├── shell/             # Zsh (vi-mode, completions, aliases), Starship, modern CLI tools
        ├── dev/               # Development languages, tooling, Neovim, Zed, AI tools
        ├── entertainment/     # Social (Vesktop, Spotify) and Gaming (MangoHud, Heroic)
        ├── productivity/      # GUI & TUI tools (Obsidian, FreeCAD, Sioyek, etc.)
        └── extra/             # Flatpaks and auxiliary applications
```

---

## 🚀 Key Features

- **Dendritic Modularity**: Zero manual import lists in `flake.nix`—every module under `modules/` and `hosts/` is auto-imported via `import-tree`.
- **Modern CLI Stack**: `zoxide` (cd), `eza` (ls), `bat` (cat), `duf` (df), `ripgrep` (grep), `fd` (find), `fzf`, and `fastfetch`.
- **High-Performance Wayland Desktop**: Hyprland managed via UWSM with hardware acceleration and zero-delay PAM hyprlock.
- **Tailored Hardware Abstraction**: Simple toggles for CPU microcode and GPU drivers (Nvidia desktop/prime offload/sync, AMD, Intel).
- **Curated Development Stack**: Go, Node, Python, Flutter, Android SDK, Docker, Direnv, Lazygit, Zed, and Neovim.

---

## 🛠️ Usage

### Build & Test
```bash
# Evaluate powerhouse configuration
nix eval --raw .#nixosConfigurations.powerhouse.config.system.build.toplevel.drvPath

# Dry-run build
nixos-rebuild build --flake .#powerhouse --dry-run
```

### Apply Configuration
```bash
# Switch to updated system configuration
sudo nixos-rebuild switch --flake .#powerhouse
```
