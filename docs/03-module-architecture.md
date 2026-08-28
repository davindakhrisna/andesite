# 🏛️ Module Architecture & Customization

> [!NOTE]
> Flint utilizes **dendritic modularity** via `flake-parts` and `import-tree`. You never need to write manual module import lists in `flake.nix`.

---

## 🌳 How It Works

* Any `.nix` file placed inside `modules/system/` is automatically exported as `self.nixosModules.<filename>`.
* Any `.nix` file placed inside `modules/home/` is automatically exported as `self.homeModules.<filename>`.

---

## 📦 Available User Modules

Enable or disable modules in `home-manager.users.<username>.imports` inside your host's `default.nix`:

```nix
home-manager.users.yourusername = {...}: {
  imports = with self.homeModules; [
    # Core Desktop Modules
    home-manager
    desktop         # Hyprland, Waybar, Rofi, Dunst, Wallust
    shell           # Zsh, Starship, modern CLI tools
    productivity    # Basalt, Basaltix, Obsidian, FreeCAD
    extra-pkgs      # Flatpak apps, ancillary utilities

    # Developer Modules (Select to your liking)
    dev             # Go, Node, Python, Docker, Direnv, mkenv
    dev-nvf         # NVF modular Neovim IDE framework
    dev-utils       # Agentic AI tools, DB managers, Zed
    dev-extra       # Game dev, Android SDK, local AI

    # Entertainment Modules
    entertainment-social  # Vesktop (Discord), Spotify
    entertainment-gaming  # Steam, MangoHud, Heroic
  ];
};
```

---

> [!TIP]
> **Creating a New Module:**
> Simply create `modules/home/my-module.nix`:
> ```nix
> {
>   flake.homeModules.my-module = { pkgs, ... }: {
>     home.packages = with pkgs; [ custom-tool ];
>   };
> }
> ```
> It is immediately importable as `self.homeModules.my-module` across all hosts!
