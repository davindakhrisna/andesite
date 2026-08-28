# 🏛️ Module Architecture & Customization

> [!NOTE]
> Flint uses **dendritic modularity** via `flake-parts` and `import-tree`. All `.nix` files under `modules/` and `hosts/` are automatically discovered and loaded into the flake outputs—no manual import arrays needed in `flake.nix`.

---

## 🌳 Dendritic Discovery Model

```
modules/
├── system/   ──▶  Exported as self.nixosModules.<module-name>
└── home/     ──▶  Exported as self.homeModules.<module-name>
```

- **`self.nixosModules.system`**: Imports all base system modules (`base`, `desktop`, `gaming`, `hardware`, `utils`).
- **`self.homeModules.<name>`**: Reusable user-space configurations imported inside each host's `home-manager.users.<user>.imports`.

---

## 📦 User Module Registry

Add or remove modules in `home-manager.users.<username>.imports` inside your host's `default.nix`:

```nix
home-manager.users.kryisnn = {...}: {
  imports = with self.homeModules; [
    # Core User Space
    home-manager           # GTK/Qt themes, cursor, XDG paths, environment variables
    desktop                # Hyprland, Waybar, Rofi, Dunst, SwayOSD, Awww
    shell                  # Zsh (vi-mode), Starship prompt, modern CLI tools
    productivity           # Basalt notes, Basaltix workspace runner, Obsidian, Sioyek
    extra-pkgs             # Flatpaks, Winboat, auxiliary desktop tools

    # Development Stack
    dev                    # Go, Node, Python, Flutter, Docker, Direnv, mkenv
    dev-nvf                # Modular Neovim IDE framework (NVF)
    dev-utils              # Zed Editor, DBGate, Bruno, Antigravity IDE, OpenCode
    dev-extra              # Godot 4, Blender, LibreSprite, uv

    # Entertainment
    entertainment-social   # Vesktop (Discord with screenshare), Spotify
    entertainment-gaming   # MangoHud, Heroic Games Launcher, Gamescope
  ];
};
```

---

## ➕ Creating a New Module

To add a new capability to Flint:

1. Create `modules/home/<category>/<my-module>.nix` (or `modules/system/<my-module>.nix`):
   ```nix
   { self, ... }: {
     flake.homeModules.my-custom-module = { pkgs, ... }: {
       home.packages = with pkgs; [ htop btop ];
     };
   }
   ```
2. Import it anywhere as `self.homeModules.my-custom-module`.

> [!TIP]
> `import-tree` discovers nested files automatically. No updates to `flake.nix` are ever required when creating new modules.
