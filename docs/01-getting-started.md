# 🚀 Getting Started & Installation

> [!NOTE]
> Flint uses a **dendritic multi-host structure** powered by `flake-parts` and `import-tree`. Adding a new machine takes under 2 minutes using the `hosts/template` blueprint.

---

## ⚡ Quick Setup & Replication

### 1. Clone Configuration
```bash
git clone https://github.com/davindakhrisna/flint.git ~/.config/flint
cd ~/.config/flint
```

### 2. Generate Hardware Scan
```bash
# Create directory for your host
mkdir -p hosts/<my-hostname>

# Dump current system hardware configuration
nixos-generate-config --show-hardware-config > hosts/<my-hostname>/_hardware.nix
```

> [!TIP]
> If using **Btrfs**, add performance mount options to `hosts/<my-hostname>/_hardware.nix`:
> ```nix
> fileSystems."/".options = [ "noatime" "compress=zstd" "discard=async" "space_cache=v2" ];
> ```

### 3. Copy & Configure Host Blueprint
```bash
cp hosts/template/default.nix hosts/<my-hostname>/default.nix
```

> [!IMPORTANT]
> Edit `hosts/<my-hostname>/default.nix` and set your machine parameters:
> - `networking.hostName = "<my-hostname>";`
> - `users.users.<username>` & `home-manager.users.<username>`
> - `programs.nh.flake = "/home/<username>/.config/flint";`
> - `var.cpu` ("intel" | "amd") and `var.gpu` ("nvidia" | "amd" | "intel")

### 4. Build & Apply
```bash
# First-time build & switch
sudo nixos-rebuild switch --flake .#<my-hostname>

# Subsequent rebuilds with nh helper
nh os switch
# (or short alias)
nos
```

---

## 🔄 Daily Workflow Commands

| Command | Alias | Action |
| :--- | :--- | :--- |
| `nh os switch` | `nos` | Build and activate system configuration |
| `nh os test` | `not` | Test configuration in memory without adding a boot entry |
| `nh os boot` | `nob` | Build configuration and add to bootloader menu without switching immediately |
| `nh clean all` | `nclean` | Remove obsolete Nix generations & reclaim disk space |
| `nix flake check --no-build` | `ncheck` | Validate flake syntax and module evaluation |
| `nix flake update` | `nup` | Update `flake.lock` dependencies |

---

> [!TIP]
> Keep your config directory clean by running `ncheck` before applying changes with `nos`.
