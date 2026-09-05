#!/bin/bash

# tmux-attach.sh - Create new tmux session or attach to existing one

# Default session name
SESSION_NAME="${1:-TERM}"

# Check if tmux is installed
if ! command -v tmux &> /dev/null; then
    echo "Error: tmux is not installed"
    exit 1
fi

# Check if the session already exists
if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    # Session exists - attach to it
    echo "Attaching to existing tmux session: $SESSION_NAME"
    tmux attach-session -t "$SESSION_NAME"
else
    # Session doesn't exist - create it
    echo "Creating new tmux session: $SESSION_NAME"
    tmux new-session -s "$SESSION_NAME"
fi
