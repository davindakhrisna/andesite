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
    │   └── utils.nix          # System packages, nh helper, Chromium fallback
    └── home/                  # Home Manager user modules (`flake.homeModules`)
        ├── home.nix           # GTK, Qt, Bibata cursor, XDG paths, environment variables
        ├── desktop/           # Hyprland (Lua), Waybar, Dunst, Rofi, Wallust, SwayOSD
        ├── shell/             # Zsh (vi-mode, completions, aliases), Starship, modern CLI tools
        ├── dev/               # Development languages, tooling, NVF (Neovim), Zed, AI tools
        ├── entertainment/     # Social (Vesktop, Spotify) and Gaming (MangoHud, Heroic)
        ├── productivity/      # GUI & TUI tools (Basalt, Basaltix, Obsidian, FreeCAD, Sioyek)
        └── extra/             # Flatpaks and auxiliary applications
```

---

## 🚀 Key Features

- **Dendritic Modularity**: Zero manual import lists in `flake.nix`—every module under `modules/` and `hosts/` is auto-imported via `import-tree`.
- **100% Dynamic Theming (Wallust Engine)**: Wallpaper-extracted color schemes dynamically theme Hyprland, Waybar, Dunst, Rofi, Kitty, GTK 3/4, Neovim (`mini.base16`), Btop, Yazi, Cava, and Hyprlock.
- **Theme Mode & Animation Physics Switcher**: Switch between Dark, Light, Soft Dark, and OLED Hard Dark (`SUPER + T`) and 5 animation physics presets (`SUPER + A`).
- **Interactive Cheatsheets**: Instant keybindings discovery (`SUPER + /` or `SUPER + F2`) and package/module explorer (`flint-pkgs` / `SUPER + Shift + P`).
- **Instant Nix-Direnv Bootstrapper (`mkenv`)**: Generate `flake.nix` and `.envrc` for Go, Rust, TypeScript, Python, C/C++, Flutter, Nix, and Zig in 1 second.
- **Multi-TUI Workspace Runner (`basaltix`)**: Multi-pane terminal workflow featuring Basalt notes on the primary pane and companion productivity tools on the side.
- **Auto Display Detection**: Listens for hotplug events on Hyprland's socket and prompts layout options (`Extend Right/Left`, `Mirror`, `External Only`).
- **Strict TUI Geometry**: Consistent 0-radius sharp brutalist aesthetic across all windows, bars, notifications, OSD HUDs, and modals.
- **Curated Development Stack**: Go, Node, Python, Flutter, Android SDK, Docker, Direnv, Lazygit, Lazydocker, Zed, and NVF Neovim.

---

## 🛠️ Usage

### Quick Commands & Management (`nh`)
```bash
# Apply configuration and switch system
nh os switch
# (or short alias)
nos

# Test configuration without adding boot entry
nh os test
# (or short alias)
not

# Check flake evaluation
nix flake check ~/.config/flint --no-build
```

### Cheatsheets & Exploration
```bash
# Explore installed packages on powerhouse
flint-pkgs --installed

# Explore all available packages across the repository
flint-pkgs --all

# Bootstrap a development environment
mkenv go
mkenv rust
mkenv ts
mkenv python
```

---

## 📖 Documentation Index

For in-depth guides and detailed configuration notes, explore the `docs/` directory:

1. [🚀 Getting Started & Installation](docs/01-getting-started.md)
2. [⚙️ Hardware Configuration (CPU/GPU)](docs/02-hardware-configuration.md)
3. [🏛️ Module Architecture & Customization](docs/03-module-architecture.md)
4. [🎨 Dynamic Theming & Wallust Engine](docs/04-theming-and-wallust.md)
5. [📦 Package & Module Discovery](docs/05-packages-and-modules.md)
6. [💻 Development Environments & Tooling](docs/06-development-environments.md)
7. [🔧 Troubleshooting & FAQ](docs/07-troubleshooting.md)

