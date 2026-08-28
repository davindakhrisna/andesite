# 📦 Package & Module Discovery

> [!NOTE]
> After installing Flint, you can instantly explore all installed tools and available modules using the interactive `flint-pkgs` package explorer.

---

## ⚡ Quick Explorer (`flint-pkgs`)

Launch the interactive package explorer anytime using **`SUPER + Shift + P`** or via the CLI:

### 1. View Currently Installed Packages (Host Profile)
Filter packages specifically active on your host (e.g., `powerhouse`):
```bash
flint-pkgs --installed
```

### 2. View All Available Packages in Repository
Browse all curated tools across all modules with real-time documentation & purpose preview:
```bash
flint-pkgs --all
```

---

## 🧭 How to Use the Interactive TUI

* **`Type to Search`**: Fuzzy search by package name, binary command, or module.
* **`Arrow Keys` / `Ctrl+j/k`**: Navigate the list; the right-hand preview pane automatically renders the package summary, module classification, and usage notes.
* **`Enter`**: View detailed package documentation.
* **`Escape` / `q`**: Exit the explorer.

---

## 📚 Module Breakdown Overview

| Module | Category | Primary Included Packages |
| :--- | :--- | :--- |
| **`desktop`** | Window Manager & UI | `hyprland`, `waybar`, `rofi`, `dunst`, `swayosd`, `wallust`, `satty`, `cliphist` |
| **`shell`** | CLI Tools & Terminal | `zsh`, `starship`, `eza`, `bat`, `duf`, `ripgrep`, `fd`, `zoxide`, `fzf` |
| **`dev`** | Core Development | `go`, `nodejs`, `python3`, `docker`, `direnv`, `mkenv`, `git`, `gh` |
| **`dev-nvf`** | Neovim IDE | `nvf` with LSP, Treesitter, mini-statusline, Wallust base16 integration |
| **`dev-utils`** | AI & Utilities | `zed-editor`, `lazygit`, `lazydocker`, `dbeaver-bin` |
| **`productivity`** | Notes & Viewers | `basalt`, `basaltix`, `obsidian`, `sioyek`, `freecad` |
| **`entertainment`** | Social & Gaming | `vesktop`, `spotify`, `steam`, `mangohud`, `heroic` |

---

> [!TIP]
> **Locating New Binaries:**
> Run `nix-locate bin/<command>` or `nix-index` to find which Nix package provides any missing binary.
