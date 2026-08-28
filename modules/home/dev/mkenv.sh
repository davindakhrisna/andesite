#!/usr/bin/env bash
set -e

# ==============================================================================
# MKENV - Instant Nix-Direnv Development Environment Bootstrapper
# ==============================================================================

show_help() {
    cat << "EOF"
================================================================================
  __  __ _  _______ _   ___     __
 |  \/  | |/ / ____| \ | \ \   / /
 | |\/| | ' /|  _| |  \| |\ \ / / 
 | |  | | . \| |___| |\  | \ V /  
 |_|  |_|_|\_\_____|_| \_|  \_/   Instant Nix-Direnv Bootstrapper
================================================================================

USAGE:
  mkenv [TEMPLATE] [OPTIONS]

AVAILABLE TEMPLATES:
  go          🐹 Go (go compiler, gopls, air live-reload, delve)
  rust        🦀 Rust (rustc, cargo, rust-analyzer, clippy, rustfmt)
  ts, node    🌐 TypeScript / Node (NodeJS 22, pnpm, typescript, biome)
  python, py  🐍 Python (Python 3, uv package manager, ruff, pyright)
  c, cpp      ⚡ C / C++ (gcc, clang-tools, cmake, gnumake, gdb)
  flutter     📱 Flutter / Mobile (Flutter SDK, OpenJDK 17, android-tools)
  nix         ❄️ Nix (nil LSP, nixd, alejandra formatter, statix)
  zig         ⚡ Zig (Zig compiler, zls language server)
  minimal     📦 Minimal (Blank devShell)

OPTIONS:
  -h, --help   Show this guide
  -f, --force  Overwrite existing flake.nix and .envrc
EOF
    exit 0
}

FORCE=0
TEMPLATE=""

for arg in "$@"; do
    case "$arg" in
        -h|--help)
            show_help
            ;;
        -f|--force)
            FORCE=1
            ;;
        *)
            if [ -z "$TEMPLATE" ]; then
                TEMPLATE="$arg"
            fi
            ;;
    esac
done

# If no template specified, prompt via FZF
if [ -z "$TEMPLATE" ]; then
    TEMPLATES_LIST="🐹 go         - Go (compiler, gopls, air, delve)
🦀 rust       - Rust (rustc, cargo, rust-analyzer, clippy)
🌐 ts         - TypeScript / Node (NodeJS 22, pnpm, biome)
🐍 python     - Python (Python 3, uv, ruff, pyright)
⚡ cpp        - C / C++ (GCC/Clang, CMake, Make, GDB)
📱 flutter    - Flutter / Android (Flutter SDK, JDK17)
❄️ nix        - Nix (nil, nixd, alejandra formatter)
⚡ zig        - Zig (Zig compiler, zls language server)
📦 minimal    - Minimal (Blank devShell)"

    CHOICE=$(echo "$TEMPLATES_LIST" | fzf \
        --prompt="Select Dev Environment > " \
        --header="MKENV :: Choose Language / Stack for nix-direnv" \
        --layout=reverse \
        --height=40% \
        --border || true)

    [ -z "$CHOICE" ] && exit 0
    TEMPLATE=$(echo "$CHOICE" | awk '{print $2}')
fi

# Normalize template name
case "$TEMPLATE" in
    go|golang)
        LANG_NAME="Go"
        PKGS="go gopls air delve golangci-lint"
        SHELL_HOOK="echo '🐹 Go environment loaded! (go: '\$(go version)')'"
        ;;
    rust|rs)
        LANG_NAME="Rust"
        PKGS="rustc cargo rust-analyzer clippy rustfmt"
        SHELL_HOOK="echo '🦀 Rust environment loaded! (cargo: '\$(cargo --version)')'"
        ;;
    ts|typescript|node|nodejs|js|javascript)
        LANG_NAME="TypeScript / Node"
        PKGS="nodejs_22 pnpm typescript typescript-language-server biome"
        SHELL_HOOK="echo '🌐 TypeScript/Node environment loaded! (node: '\$(node -v)')'"
        ;;
    python|py)
        LANG_NAME="Python"
        PKGS="python311 uv ruff pyright python311Packages.pip"
        SHELL_HOOK="echo '🐍 Python environment loaded! (python: '\$(python3 --version)')'"
        ;;
    c|cpp|c++)
        LANG_NAME="C / C++"
        PKGS="gcc clang-tools gnumake cmake pkg-config gdb"
        SHELL_HOOK="echo '⚡ C/C++ environment loaded! (gcc: '\$(gcc --version | head -n 1)')'"
        ;;
    flutter|dart|android)
        LANG_NAME="Flutter / Android"
        PKGS="flutter jdk17 android-tools"
        SHELL_HOOK="echo '📱 Flutter environment loaded! (flutter: '\$(flutter --version | head -n 1)')'"
        ;;
    nix)
        LANG_NAME="Nix"
        PKGS="nil nixd alejandra statix nix-prefetch-github"
        SHELL_HOOK="echo '❄️ Nix development environment loaded!'"
        ;;
    zig)
        LANG_NAME="Zig"
        PKGS="zig zls"
        SHELL_HOOK="echo '⚡ Zig environment loaded! (zig: '\$(zig version)')'"
        ;;
    minimal|base|blank)
        LANG_NAME="Minimal"
        PKGS="git coreutils bashInteractive"
        SHELL_HOOK="echo '📦 Minimal development environment loaded!'"
        ;;
    *)
        echo "Error: Unknown template '$TEMPLATE'. Run 'mkenv --help' for available templates." >&2
        exit 1
        ;;
esac

# Check for existing flake.nix
if [ -f "flake.nix" ] && [ "$FORCE" -eq 0 ]; then
    echo "Warning: 'flake.nix' already exists in current directory."
    read -p "Overwrite existing flake.nix and .envrc? [y/N] " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Aborted."
        exit 0
    fi
fi

# 1. Write flake.nix
cat > flake.nix << EOF
{
  description = "${LANG_NAME} Development Environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
      in {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            ${PKGS}
          ];

          shellHook = ''
            ${SHELL_HOOK}
          '';
        };
      });
}
EOF

# 2. Write .envrc
echo "use flake" > .envrc

# 3. Add to git if inside git repository (so Nix recognizes untracked flake)
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    git add -N flake.nix 2>/dev/null || true
fi

# 4. Allow direnv
if command -v direnv >/dev/null 2>&1; then
    direnv allow
fi

echo "✨ Successfully initialized ${LANG_NAME} development environment with nix-direnv!"
if command -v notify-send >/dev/null 2>&1; then
    notify-send -u low -i preferences-desktop-theme \
        "mkenv" "Initialized <b>${LANG_NAME}</b> environment (nix-direnv active)"
fi
