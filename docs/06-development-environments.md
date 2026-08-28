# 💻 Development Environments & Tooling

> [!NOTE]
> Flint provides per-project hermetic development environments using `nix-direnv` and the `mkenv` template bootstrapper.

---

## ⚡ Instant Environment Bootstrapper (`mkenv`)

Initialize a reproducible Nix development shell in any directory:

```bash
# Syntax: mkenv <preset>
mkenv go
mkenv rust
mkenv ts
mkenv python
mkenv flutter
mkenv zig
mkenv c
mkenv nix
```

### What `mkenv` Generates:
1. `flake.nix`: Declares exact compiler versions, build tools, and LSPs for the chosen stack.
2. `.envrc`: Configured with `use flake` for `direnv`.
3. `.gitignore`: Ignores `.direnv` and build artifacts.
4. Automatically runs `direnv allow` to activate the environment immediately.

> [!TIP]
> Whenever you `cd` into the project directory, all compilers, runtimes, and language servers load automatically into your shell and Neovim/Zed sessions.

---

## 🛠️ Modern CLI Aliases & Replacements

| Modern Tool | Replaced Command | Alias / Command | Benefit |
| :--- | :--- | :--- | :--- |
| **`eza`** | `ls` | `tree` (`eza --tree`) | Icons, Git status, file permissions color coding |
| **`bat`** | `cat` | `cat` (with hint) / `bat` | Syntax highlighting and line numbers |
| **`ripgrep`** | `grep` | `rg` | Blazing-fast recursive directory search |
| **`fd`** | `find` | `fd` | Intuitive syntax, respects `.gitignore` |
| **`duf`** | `df` | `duf` | Clean visual terminal disk usage tables |
| **`zoxide`** | `cd` | `z <path>` | Smart directory jumping based on frecency |
| **`lazygit`** | `git` | `g` | Interactive full-featured Git TUI |
| **`lazydocker`** | `docker` | `lazydocker` | Container, image, and volume monitoring TUI |

---

## 📱 Mobile Development & Android / Waydroid

Flint includes preconfigured Android tools and system-level Waydroid integration:

```bash
# Initialize Waydroid with Google Apps support
sudo waydroid init -s GAPPS

# Start the Waydroid container service
sudo systemctl start waydroid-container

# Launch Android window in Hyprland
waydroid show-full-ui
```
