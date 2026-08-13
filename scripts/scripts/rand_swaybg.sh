#!/usr/bin/env bash
#
# wall.sh — cycles swaybg wallpapers from a folder on an interval
#
# Usage:
#   wall.sh [-d DIR] [-i SECONDS] [-m MODE] [-r]
#
#   -d DIR      wallpaper folder (default: ~/Pictures/wallpapers)
#   -i SECONDS  seconds between changes (default: 300)
#   -m MODE     swaybg mode: stretch, fit, fill, center, tile (default: fill)
#   -r          shuffle order instead of alphabetical
#
# Run in the background from your Niri config, e.g.:
#   spawn-at-startup "wall.sh" "-d" "/home/nahi/Pictures/wallpapers" "-i" "600"

set -euo pipefail

DIR="${HOME}/Pictures/retro-tech"
INTERVAL=300
MODE="fill"
SHUFFLE=0

while getopts "d:i:m:r" opt; do
    case "$opt" in
        d) DIR="$OPTARG" ;;
        i) INTERVAL="$OPTARG" ;;
        m) MODE="$OPTARG" ;;
        r) SHUFFLE=1 ;;
        *) echo "Usage: $0 [-d DIR] [-i SECONDS] [-m MODE] [-r]" >&2; exit 1 ;;
    esac
done

if [ ! -d "$DIR" ]; then
    echo "wall.sh: directory not found: $DIR" >&2
    exit 1
fi

if ! command -v swaybg >/dev/null 2>&1; then
    echo "wall.sh: swaybg not found in PATH" >&2
    exit 1
fi

CURRENT_PID=""

cleanup() {
    if [ -n "$CURRENT_PID" ] && kill -0 "$CURRENT_PID" 2>/dev/null; then
        kill "$CURRENT_PID" 2>/dev/null
    fi
    exit 0
}
trap cleanup INT TERM

while true; do
    mapfile -t FILES < <(find "$DIR" -maxdepth 1 -type f \
        \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' -o -iname '*.bmp' \) \
        | sort)

    if [ "${#FILES[@]}" -eq 0 ]; then
        echo "wall.sh: no images found in $DIR" >&2
        exit 1
    fi

    if [ "$SHUFFLE" -eq 1 ]; then
        mapfile -t FILES < <(printf '%s\n' "${FILES[@]}" | shuf)
    fi

    for img in "${FILES[@]}"; do
        # Start the new wallpaper first, then kill the old one —
        # avoids a flash of blank/black screen between swaps.
        swaybg -i "$img" -m "$MODE" &
        NEW_PID=$!

        sleep 1

        if [ -n "$CURRENT_PID" ] && kill -0 "$CURRENT_PID" 2>/dev/null; then
            kill "$CURRENT_PID" 2>/dev/null
        fi
        CURRENT_PID=$NEW_PID

        sleep "$INTERVAL"
    done
done
