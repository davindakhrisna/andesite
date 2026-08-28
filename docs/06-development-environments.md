# 💻 Development Environments & Tooling

> [!NOTE]
> Flint includes `mkenv` and `nix-direnv` for instant, zero-friction isolated development shells.

---

## ⚡ Instant Nix-Direnv Bootstrapper (`mkenv`)

Inside any project directory, initialize an isolated dev environment:

```bash
# Available presets: go, rust, ts, python, zig, flutter, c, nix, minimal
mkenv go
```

### What `mkenv` Does:
1. Generates a standalone `flake.nix` with preconfigured toolchains and LSP packages.
2. Creates `.envrc` and automatically executes `direnv allow`.
3. Sets up `.gitignore` for direnv and nix caches.

> [!TIP]
> Whenever you `cd` into the project directory, all compilers, runtimes, and LSPs load automatically into your shell and Neovim/Zed.

---

## 🛠️ Integrated Tooling & Aliases

| Tool / Alias | Base Command | Description |
| :--- | :--- | :--- |
| `z <dir>` | `cd` | Fast directory jumping with frecency (zoxide) |
| `eza` | `ls` | Modern file listing with icons and Git status |
| `bat` | `cat` | Syntax-highlighted file viewing |
| `duf` | `df` | Intuitive disk usage analysis |
| `rg` | `grep` | Blazing fast recursive search (ripgrep) |
| `fd` | `find` | User-friendly file search |
| `lg` | `lazygit` | Terminal UI for Git |
| `ld` | `lazydocker` | Terminal UI for Docker containers |
| `nv` | `nvim` | Modular Neovim (NVF framework) |

---

## 📱 Mobile Development & Waydroid

```bash
# Initialize Waydroid container with Google Play Services
sudo waydroid init -s GAPPS

# Start Android container service
sudo systemctl start waydroid-container

# Launch Android UI window
waydroid show-full-ui
```
