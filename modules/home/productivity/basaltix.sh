#!/usr/bin/env bash
set -e

# ==============================================================================
# BASALTIX - Multi-TUI Productivity Workspace Runner
# ==============================================================================

# Default Main App
MAIN_APP="basalt"

# Show Help Guide
show_help() {
    cat << "EOF"
================================================================================
  ____                 _ _   _      
 | __ )  __ _ ___  __ _| | |_(_)_  __
 |  _ \ / _` / __|/ _` | | __| \ \/ /
 | |_) | (_| \__ \ (_| | | |_| |>  < 
 |____/ \__,_|___/\__,_|_|\__|_/_/\_\  Multi-TUI Workspace Runner
================================================================================

DESCRIPTION:
  Basaltix creates a tiled tmux workspace featuring Basalt (Note Taker)
  on the left (main/largest pane) and up to 2 companion TUI productivity
  apps on the right.

LAYOUT:
  ┌────────────────────────────────────┬────────────────────────┐
  │                                    │   Companion App 1      │
  │                                    │   (e.g., Pomo Timer)   │
  │           BASALT TUI               ├────────────────────────┤
  │       (Primary Workspace)          │   Companion App 2      │
  │                                    │   (e.g., HackerNews)   │
  └────────────────────────────────────┴────────────────────────┘

USAGE:
  basaltix [OPTIONS] [COMPANION_APPS...]

OPTIONS:
  -h, --help        Show this guide and available TUI apps
  -l, --list        List detected productivity TUI applications

EXAMPLES:
  basaltix                    # Interactive menu to select companion apps
  basaltix pomo               # Basalt (left) + Pomo timer (right)
  basaltix pomo hackernews_tui # Basalt (left) + Pomo (top-right) + HN (bottom-right)

KEYBOARD SHORTCUTS IN TMUX:
  Ctrl+b Arrow      Switch between panes
  Ctrl+b z          Toggle zoom current pane to fullscreen
  Ctrl+b d          Detach workspace session
  Exit in Basalt    Closes the entire workspace cleanly
EOF
    exit 0
}

# Registered Productivity TUI Apps
declare -A APP_NAMES=(
    ["pomo"]="Pomo - Pomodoro Focus Timer & Task Tracker"
    ["hackernews_tui"]="HackerNews TUI - Y Combinator News Reader"
    ["gazelle-tui"]="Gazelle - NetworkManager WiFi Manager"
    ["pi-coding-agent"]="Pi Agent - AI Assistant for Feedback Loop"
)

# List Available Apps
list_apps() {
    echo "Detected Productivity TUI Applications:"
    for cmd in "${!APP_NAMES[@]}"; do
        if command -v "$cmd" >/dev/null 2>&1; then
            printf "  %-18s : %s\n" "$cmd" "${APP_NAMES[$cmd]}"
        fi
    done
    exit 0
}

# Handle Arguments
case "${1:-}" in
    -h|--help)
        show_help
        ;;
    -l|--list)
        list_apps
        ;;
esac

# Check if main app exists
if ! command -v "$MAIN_APP" >/dev/null 2>&1; then
    echo "Error: Primary note-taking app '$MAIN_APP' is not installed in PATH." >&2
    exit 1
fi

SELECTED_APPS=()

if [ "$#" -gt 0 ]; then
    # Passed via CLI arguments
    for arg in "$@"; do
        if [ "$arg" != "$MAIN_APP" ]; then
            SELECTED_APPS+=("$arg")
        fi
    done
else
    # Interactive Selection using FZF
    AVAILABLE_LIST=""
    for cmd in "${!APP_NAMES[@]}"; do
        if command -v "$cmd" >/dev/null 2>&1 && [ "$cmd" != "$MAIN_APP" ]; then
            AVAILABLE_LIST="${AVAILABLE_LIST}${cmd} - ${APP_NAMES[$cmd]}"$'\n'
        fi
    done

    if [ -n "$AVAILABLE_LIST" ]; then
        CHOICES=$(echo -n "$AVAILABLE_LIST" | fzf \
            --multi=2 \
            --prompt="Select companion TUIs > " \
            --header="BASALTIX :: [Tab] Toggle (Max 2) | [Enter] Launch | [Esc] Basalt Only" \
            --layout=reverse \
            --height=45% \
            --border \
            --color=bg+:#313244,bg:#181825,spinner:#f5e0dc,hl:#f38ba8 \
            --color=fg:#cdd6f4,header:#cba6f7,info:#cba6f7,pointer:#f5e0dc \
            --color=marker:#a6e3a1,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
            || true)

        if [ -n "$CHOICES" ]; then
            while IFS= read -r line; do
                [ -z "$line" ] && continue
                APP_CMD=$(echo "$line" | awk '{print $1}')
                SELECTED_APPS+=("$APP_CMD")
            done <<< "$CHOICES"
        fi
    fi
fi

# Limit to max 2 companion apps
COUNT=${#SELECTED_APPS[@]}
if [ "$COUNT" -gt 2 ]; then
    SELECTED_APPS=("${SELECTED_APPS[0]}" "${SELECTED_APPS[1]}")
    COUNT=2
fi

SESSION_NAME="basaltix-$$"

# 1. Create session with Basalt in main left pane
tmux new-session -d -s "$SESSION_NAME" -n "workspace" "$MAIN_APP"

# Set Tmux styling and options
tmux set-option -t "$SESSION_NAME" mouse on
tmux set-option -t "$SESSION_NAME" status off
tmux set-option -t "$SESSION_NAME" pane-border-style "fg=#313244"
tmux set-option -t "$SESSION_NAME" pane-active-border-style "fg=#8e94a8"

if [ "$COUNT" -eq 1 ]; then
    APP1="${SELECTED_APPS[0]}"
    # Split right pane (35% width)
    tmux split-window -h -t "$SESSION_NAME:0.0" -p 35 "$APP1"
    tmux select-pane -t "$SESSION_NAME:0.0"
elif [ "$COUNT" -eq 2 ]; then
    APP1="${SELECTED_APPS[0]}"
    APP2="${SELECTED_APPS[1]}"
    # Split right side (35% width)
    tmux split-window -h -t "$SESSION_NAME:0.0" -p 35 "$APP1"
    # Split right side vertically (50% height)
    tmux split-window -v -t "$SESSION_NAME:0.1" -p 50 "$APP2"
    tmux select-pane -t "$SESSION_NAME:0.0"
fi

# Attach to tmux session
exec tmux attach-session -t "$SESSION_NAME"
