#!/usr/bin/env bash
set -e

# ==============================================================================
# Flint Packages & Modules Cheatsheet Explorer
# ==============================================================================

# Package Catalog Definition:
# Format: MODULE|PACKAGE|BINARY|INSTALLED(1/0)|SUMMARY|DESCRIPTION_AND_README
PACKAGES_DATA=(
    # --- SHELL MODULE ---
    "shell|bat|bat|1|Modern cat replacement with syntax highlighting and Git integration|Syntax-highlighting cat pager. Integrates with git to show modifications. Used as MANPAGER."
    "shell|eza|eza|1|Modern, feature-rich replacement for ls with colors and icons|Fast, color-coded file lister with tree view, git status, and icon support. Alias: ls -> eza."
    "shell|duf|duf|1|Disk Usage/Free Utility with intuitive graphical tables|User-friendly disk free monitor. Displays mount points, usage percent, and filesystems cleanly."
    "shell|ripgrep|rg|1|Blazing fast recursive regex line search tool|Ultra-fast line-oriented search tool. Respects .gitignore rules automatically."
    "shell|fd|fd|1|Simple, fast, and user-friendly alternative to find|Intuitive file finder with regex support, colorized output, and parallel directory traversal."
    "shell|zoxide|z|1|Smarter cd command that remembers your most-used directories|Fuzzy directory jumper. Type 'z <partial_name>' to instantly navigate to frequently visited paths."
    "shell|fzf|fzf|1|General-purpose command-line fuzzy finder|Interactive fuzzy finder for files, history (Ctrl+R), directories (Alt+C), and pipes."
    "shell|starship|starship|1|Fast, customizable, cross-shell prompt with Git & language status|Prompt showing current git branch, node/go/rust versions, execution time, and error status."

    # --- DESKTOP MODULE ---
    "desktop|rofi|rofi|1|Window switcher, application launcher, and dmenu replacement|Dynamic launcher, power menu, clipboard, and theme switcher modal engine."
    "desktop|thunar|thunar|1|Modern and fast graphical file manager for desktop|Lightweight XFCE file manager with tab support, drag & drop, and file preview."
    "desktop|wiremix|wiremix|1|PipeWire TUI audio mixer and volume control|Interactive terminal mixer for managing audio input/output devices, streams, and volume levels."
    "desktop|bluetui|bluetui|1|TUI Bluetooth manager for pairing and connecting devices|Terminal interface for bluetoothctl. Scan, pair, trust, and connect bluetooth peripherals."
    "desktop|gazelle-tui|gazelle-tui|1|NetworkManager WiFi and Ethernet TUI connection manager|Interactive WiFi scanner and connection manager for NetworkManager in terminal."
    "desktop|hyprmon|hyprmon|1|Hyprland Monitor layout and display settings TUI|Terminal dashboard to inspect, arrange, and manage connected Wayland displays in Hyprland."
    "desktop|wlr-randr|wlr-randr|1|Wayland xrandr equivalent for querying and setting outputs|CLI utility to set display resolution, refresh rate, position, and orientation."
    "desktop|hyprsunset|hyprsunset|1|Blue-light filter and color temperature night-light utility|Adjusts screen color temperature for night work (SUPER+N toggles 4500K warm filter)."
    "desktop|grim|grim|1|Grab images from a Wayland compositor|Core screenshot capture tool for Hyprland/Wayland."
    "desktop|slurp|slurp|1|Select a region in a Wayland compositor|Interactive area and window selector used with grim for region screenshots."
    "desktop|satty|satty|1|Modern screenshot annotation suite and image editor|Annotation tool for adding arrows, text, highlights, crops, and blur to screenshots."
    "desktop|cliphist|cliphist|1|Wayland clipboard history manager|Captures text and image clipboard entries. Integrated with Rofi (SUPER+V)."
    "desktop|rofimoji|rofimoji|1|Emoji, math, and unicode glyph picker for Rofi|Interactive emoji and unicode character picker with clipboard copy (SUPER+.)."
    "desktop|wallust|wallust|1|Dynamic colors generator and theming engine from wallpapers|Extracts color schemes from wallpapers and dynamically templates Hyprland, Waybar, Dunst, etc."
    "desktop|awww|awww|1|High-performance Wayland wallpaper daemon with animated transitions|Smooth wallpaper display daemon supporting transitions and multi-monitor setups."

    # --- PRODUCTIVITY MODULE ---
    "productivity|basalt|basalt|1|Minimalist TUI note-taker and Markdown knowledge base|Terminal note-taking application designed for rapid markdown journaling and personal knowledge."
    "productivity|basaltix|basaltix|1|Multi-TUI workspace manager (Basalt + Companion TUIs in Tmux)|Launches Basalt on left pane (~65% width) with up to 2 productivity companions on right."
    "productivity|hackernews-tui|hackernews_tui|1|Terminal viewer for Hacker News discussions and stories|Read frontpage stories, comments, ask/show HN threads directly inside terminal."
    "productivity|pomo|pomo|1|Pomodoro focus timer and productivity task tracker|Terminal pomodoro timer with customizable intervals and notifications."
    "productivity|sioyek|sioyek|1|Research paper and PDF viewer for technical reading|PDF reader optimized for textbooks and research papers with jumping, portals, and synctex."
    "productivity|obsidian|obsidian|1|Extensible Markdown knowledge base and second brain|Graph-based personal note-taking and knowledge management desktop suite."
    "productivity|xournalpp|xournalpp|1|Handwriting, PDF annotation, and digital sketchpad|Handwritten notes, PDF markup, and stylus drawing application."
    "productivity|onlyoffice-desktopeditors|onlyoffice|1|Complete office productivity suite (Docs, Sheets, Slides)|Office document editor compatible with MS Office DOCX, XLSX, and PPTX formats."
    "productivity|pdfarranger|pdfarranger|1|Visual PDF page merger, splitter, and rotator|Graphical utility to split, merge, crop, and re-arrange PDF document pages."
    "productivity|freecad|freecad|1|Parametric 3D CAD modeler for engineering and product design|3D mechanical design and parametric CAD software."

    # --- DEV MODULE ---
    "dev|mkenv|mkenv|1|Instant Nix-Direnv development environment bootstrapper|CLI tool to generate flake.nix, .envrc, and allow direnv for Go, Rust, TS, Python, C++, etc."
    "dev|go|go|1|Go programming language compiler and standard library|Fast, statically typed compiled language for cloud and systems engineering."
    "dev|nodejs|node|1|Node.js JavaScript runtime environment (V8 engine)|Server-side JavaScript runtime for web development and tooling."
    "dev|python3|python3|1|Python 3 interpreter and standard ecosystem|Interpreted, high-level general-purpose programming language."
    "dev|pnpm|pnpm|1|Fast, disk space-efficient package manager for Node.js|Symlink-based npm alternative that saves disk space and accelerates installs."
    "dev|air|air|1|Live-reload utility for Go applications|Watches Go files and automatically re-compiles & restarts servers on change."
    "dev|gcc|gcc|1|GNU Compiler Collection (C/C++ compilers)|Essential C and C++ compiler toolchain."
    "dev|gnumake|make|1|GNU Make build automation tool|Standard build automation and dependency tracking utility."
    "dev|pkg-config|pkg-config|1|Helper tool for compiling applications and libraries|Queries installed libraries for compile and link flags."
    "dev|flutter|flutter|1|Google UI toolkit for building multi-platform apps|Dart-based SDK for cross-platform Android, iOS, and desktop applications."
    "dev|jdk17|java|1|OpenJDK 17 Java Development Kit|Java runtime and compiler required for Android SDK and Java development."
    "dev|android-tools|adb|1|Android debugging bridge (adb) and fastboot tools|Tools to flash, debug, and communicate with Android devices."
    "dev|sqlite|sqlite3|1|Self-contained, serverless SQL database engine|Embedded SQL database engine and interactive CLI shell."
    "dev|lazygit|lazygit|1|Simple terminal UI for git commands|Interactive TUI for git staging, commits, branches, rebase, and diffs."
    "dev|lazydocker|lazydocker|1|Terminal UI for Docker containers and compose stacks|Interactive dashboard to view containers, logs, CPU/RAM usage, and images."
    "dev|jq|jq|1|Command-line JSON processor and filter|Lightweight and flexible command-line JSON processor for scripting."
    "dev|alejandra|alejandra|1|The uncompromising Nix code formatter|Opinionated, fast formatter for Nix expression files."
    "dev|nixfmt|nixfmt|1|Official Nix code formatter|Standard formatter for Nix codebase compliance."

    # --- DEV-NVF MODULE ---
    "dev-nvf|nvf|nvim|1|Declarative Neovim IDE (Catppuccin Mocha, LSP, Treesitter, Explorer)|Full-featured Neovim distribution with Mini suite, Neo-Tree, Telescope, Flash, and Trouble."

    # --- DEV-UTILS MODULE ---
    "dev-utils|zed-editor|zed|1|High-performance, multiplayer code editor written in Rust|Ultra-fast GUI code editor with built-in LSP, vim mode, and AI features."
    "dev-utils|dbgate|dbgate|1|Database manager for SQL and NoSQL databases|GUI client for PostgreSQL, MySQL, SQLite, MongoDB, Redis, and SQL Server."
    "dev-utils|bruno|bruno|1|Fast, git-friendly API client (Postman/Insomnia alternative)|Local-first API client using plain text files for version-controlled requests."
    "dev-utils|google-antigravity-ide|antigravity|1|Google Advanced AI Agentic Pair Programming IDE|AI-powered development environment for complex coding tasks."
    "dev-utils|opencode|opencode|1|Open-source AI coding assistant and agent interface|Agentic AI terminal client and IDE integration."

    # --- DEV-EXTRA MODULE ---
    "dev-extra|uv|uv|1|Extremely fast Python package installer and resolver written in Rust|Rust-based drop-in replacement for pip and pip-tools with 10-100x speedups."
    "dev-extra|godot_4|godot|1|Free and open-source 2D and 3D game engine|Feature-packed game engine with GDScript, C#, and 2D/3D physics."
    "dev-extra|blender|blender|1|3D creation suite (modeling, rigging, animation, rendering)|Professional 3D computer graphics software."
    "dev-extra|libresprite|libresprite|1|Animated sprite editor and pixel art tool (Aseprite fork)|Pixel art tool for game asset creation and sprite sheet animation."

    # --- ENTERTAINMENT-SOCIAL MODULE ---
    "entertainment-social|discord|discord|1|All-in-one voice and text chat platform|Social communication client for gaming communities and developer groups."
    "entertainment-social|vesktop|vesktop|1|Custom Discord client with Vencord plugins and screen sharing|Lightweight Discord client optimized for Wayland screen sharing."
    "entertainment-social|telegram-desktop|telegram-desktop|1|Fast and secure messaging app desktop client|Telegram desktop messaging and channels client."
    "entertainment-social|spotify|spotify|1|Digital music, podcast, and streaming service|Music streaming desktop application."

    # --- ENTERTAINMENT-GAMING MODULE ---
    "entertainment-gaming|steam|steam|1|Digital distribution platform for PC gaming|Game store, launcher, and Proton compatibility layer for Linux gaming."
    "entertainment-gaming|lutris|lutris|1|Open gaming platform for managing Windows & Linux games|Game manager for Wine, Proton, emulators, and GOG/Epic stores."
    "entertainment-gaming|mangohud|mangohud|1|Vulkan and OpenGL overlay for monitoring FPS, GPU, CPU, and temps|On-screen display (OSD) for gaming performance diagnostics."
    "entertainment-gaming|gamemode|gamemoded|1|Daemon to optimize Linux system performance on demand|Adjusts CPU governor and scheduler priorities during gaming."
    "entertainment-gaming|heroic|heroic|1|Native launcher for Epic Games, GOG, and Amazon Games|Game launcher for Epic and GOG libraries with Wine/Proton integration."

    # --- EXTRA-PKGS MODULE ---
    "extra-pkgs|ffmpeg|ffmpeg|1|Complete solution to record, convert and stream audio and video|Universal multimedia processing toolkit."
    "extra-pkgs|imagemagick|magick|1|Command-line image manipulation and conversion suite|CLI bitmap image creation, editing, and format conversion tool."
    "extra-pkgs|p7zip|7z|1|High-compression 7-Zip file archiver|7z archive extraction and compression utility."
    "extra-pkgs|unrar|unrar|1|RAR archive extraction tool|Utility to extract .rar files."
    "extra-pkgs|fastfetch|fastfetch|1|Neofetch-like tool for fetching system information and logo|Blazing fast system information fetcher with logo rendering."
)

# Helper: Render FZF Preview Pane for a Given Line
if [ "${1:-}" = "--preview-item" ]; then
    LINE="${2:-}"
    MODULE=$(echo "$LINE" | awk -F"│" '{print $1}' | tr -d "[] ")
    PKG=$(echo "$LINE" | awk -F"│" '{print $2}' | tr -d " ")

    echo "================================================================================"
    echo "📦 PACKAGE: $PKG"
    echo "📂 MODULE:  $MODULE"
    echo "================================================================================"
    echo ""

    for entry in "${PACKAGES_DATA[@]}"; do
        IFS="|" read -r m p b _ s d <<< "$entry"
        if [ "$p" = "$PKG" ] && [ "$m" = "$MODULE" ]; then
            echo "⚡ Binary / Command: $b"
            echo "📝 Summary:          $s"
            echo ""
            echo "📖 Detailed Description & Purpose:"
            echo "--------------------------------------------------------------------------------"
            echo "$d"
            echo "--------------------------------------------------------------------------------"
            break
        fi
    done
    exit 0
fi

show_help() {
    cat << "EOF"
================================================================================
  _____ _     ___ _   _ _____   ____  _  ______ ____  
 |  ___| |   |_ _| \ | |_   _| |  _ \| |/ / ___/ ___| 
 | |_  | |    | ||  \| | | |   | |_) | ' /\___ \___ \ 
 |  _| | |___ | || |\  | | |   |  __/| . \ ___) |__) |
 |_|   |_____|___|_| \_| |_|   |_|   |_|\_\____/____/  Flint Package Explorer
================================================================================

USAGE:
  flint-pkgs [OPTIONS]

OPTIONS:
  -i, --installed  Show only packages installed on current host (powerhouse)
  -a, --all        Show all available modules & packages across repository
  -h, --help       Show this guide
EOF
    exit 0
}

MODE=""
for arg in "$@"; do
    case "$arg" in
        -h|--help) show_help ;;
        -i|--installed) MODE="installed" ;;
        -a|--all) MODE="all" ;;
    esac
done

# If mode not set via CLI flag, ask user
if [ -z "$MODE" ]; then
    if [ -t 0 ] && command -v fzf >/dev/null 2>&1; then
        SELECTION=$(printf "📦 Installed Packages (Host: powerhouse)\n🌐 All Available Modules & Packages\n" | fzf \
            --prompt="Select View Mode > " \
            --header="FLINT PACKAGES CHEATSHEET" \
            --height=20% \
            --layout=reverse \
            --border || true)

        case "$SELECTION" in
            *"Installed"*) MODE="installed" ;;
            *"All"*) MODE="all" ;;
            *) exit 0 ;;
        esac
    else
        MODE="installed"
    fi
fi

# Build FZF Input Stream
generate_fzf_input() {
    for entry in "${PACKAGES_DATA[@]}"; do
        IFS="|" read -r module pkg _ installed summary _ <<< "$entry"
        if [ "$MODE" = "installed" ] && [ "$installed" -ne 1 ]; then
            continue
        fi
        printf "%-22s │ %-24s │ %s\n" "[$module]" "$pkg" "$summary"
    done
}

# Run FZF with Dynamic Preview
if command -v fzf >/dev/null 2>&1; then
    SELECTED=$(generate_fzf_input | fzf \
        --prompt="Flint Packages ($MODE) > " \
        --header="[Enter] View Details | [Esc] Exit" \
        --layout=reverse \
        --border \
        --height=90% \
        --preview="flint-pkgs --preview-item {}" \
        --preview-window=right:55%:wrap)

    [ -z "$SELECTED" ] && exit 0
else
    # Fallback plain text table
    echo "================================================================================"
    echo "FLINT PACKAGES & MODULES ($MODE)"
    echo "================================================================================"
    generate_fzf_input
fi
