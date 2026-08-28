# 🚀 Getting Started & Installation

> [!NOTE]
> Flint is designed for quick replication across multiple machines using the `hosts/template` blueprint.

---

## ⚡ Quick TL;DR Setup

### 1. Clone Configuration
```bash
git clone https://github.com/davindakhrisna/flint.git ~/.config/flint
cd ~/.config/flint
```

### 2. Generate Hardware Config
```bash
# Create directory for your host
mkdir -p hosts/my-laptop

# Dump active hardware configuration
nixos-generate-config --show-hardware-config > hosts/my-laptop/_hardware.nix
```

### 3. Duplicate & Edit Host Template
```bash
cp hosts/template/default.nix hosts/my-laptop/default.nix
```

> [!IMPORTANT]
> Edit `hosts/my-laptop/default.nix` and update all lines marked with `# CHANGEME`:
> - `networking.hostName = "my-laptop";`
> - `users.users.<yourusername>` & `home-manager.users.<yourusername>`
> - `programs.nh.flake = "/home/<yourusername>/.config/flint";`
> - `var.cpu` and `var.gpu` (see [Hardware Guide](02-hardware-configuration.md))

### 4. Build & Apply
```bash
# First-time rebuild
sudo nixos-rebuild switch --flake .#my-laptop

# Subsequent updates (using nh helper)
nh os switch
# (or short alias)
nos
```

---

## 🔄 Daily Workflow Commands

| Command | Alias | Description |
| :--- | :--- | :--- |
| `nh os switch` | `nos` | Build and switch system configuration |
| `nh os test` | `not` | Test configuration without adding boot entry |
| `nh clean all` | - | Garbage collect old Nix generations & save disk space |
| `nix flake check --no-build` | `ncheck` | Validate flake evaluation and syntax |
| `nix flake update` | `nup` | Update all flake lock inputs |
