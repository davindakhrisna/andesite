# 📦 Package & Module Discovery

> [!NOTE]
> Flint includes interactive discovery tools (`flint-pkgs` and `ns`) to explore installed tools, search Nixpkgs, and inspect module composition.

---

## ⚡ Interactive Package Explorer (`flint-pkgs`)

Launch the package explorer with **`SUPER + P`** or via terminal:

```bash
# Browse packages installed on current host
flint-pkgs --installed

# Browse all curated tools across all modules in the repository
flint-pkgs --all
```

### Keybindings in `flint-pkgs`:
- **`Type to Filter`**: Instant fuzzy search across package names, binaries, and module tags.
- **`Up / Down` (`Ctrl+j / Ctrl+k`)**: Navigate list with real-time summary preview on the right pane.
- **`Enter`**: View detailed package documentation.
- **`Esc / q`**: Exit.

---

## 📚 Module Package Breakdown

| Module | Category | Primary Included Packages |
| :--- | :--- | :--- |
| **`desktop`** | Window Manager & UI | `hyprland`, `waybar`, `rofi`, `dunst`, `swayosd`, `awww`, `satty`, `cliphist`, `wiremix`, `bluetui`, `gazelle-tui`, `hyprmon`, `hyprsunset` |
| **`shell`** | CLI Tools & Terminal | `zsh`, `starship`, `eza`, `bat`, `duf`, `ripgrep`, `fd`, `zoxide`, `fzf`, `fastfetch`, `areofyl-fetch`, `playerctl`, `brightnessctl`, `yt-dlp` |
| **`dev`** | Core Development | `go`, `nodejs`, `pnpm`, `python3`, `flutter`, `android-tools`, `docker`, `direnv`, `mkenv`, `git`, `gh`, `lazygit`, `lazydocker`, `jq` |
| **`dev-nvf`** | Neovim IDE | `nvf` (LSP, Treesitter, mini.statusline, Telescope, Neo-tree, Trouble, Flash, Gitsigns) |
| **`dev-utils`** | AI & GUI Editors | `zed-editor`, `dbgate`, `bruno`, `google-antigravity-ide`, `opencode` |
| **`dev-extra`** | Game Dev & Local AI | `godot_4`, `blender`, `libresprite`, `uv` |
| **`productivity`** | Notes & Viewers | `basalt`, `basaltix`, `pomo`, `hackernews-tui`, `pi-coding-agent`, `obsidian`, `xournalpp`, `onlyoffice-desktopeditors`, `sioyek`, `freecad` |
| **`entertainment`** | Social & Gaming | `vesktop`, `spotify`, `steam`, `mangohud`, `protonup-qt`, `heroic`, `gamescope` |
| **`extra-pkgs`** | Flatpak & Aux | Flatpak service (`OBS Studio`, `Sober`), `winboat` |

---

## 🔍 Searching for New Packages (`ns`)

```bash
# Instant interactive TUI search across 100,000+ Nixpkgs packages
ns <search-term>
```

> [!TIP]
> To find which Nix package provides a specific terminal binary, use:
> ```bash
> nix-locate bin/<command>
> ```
