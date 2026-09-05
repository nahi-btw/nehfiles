#!/bin/bash
# ~/alacritty-godmode.sh

WINDOW_CLASS="AlacrittyTTY"

# Launch with extreme prejudice
launch() {
    alacritty --class "$WINDOW_CLASS" --title "TTY" \
        --option window.decorations=none \
        --option window.fullscreen=true &
    
    sleep 1
    WIN_ID=$(xdotool search --class "$WINDOW_CLASS" | head -1)
    
    # Force fullscreen even if config ignored
    xdotool windowmap "$WIN_ID"
    xdotool windowfocus "$WIN_ID"
    xdotool windowmove "$WIN_ID" 0 0
    
    SCREEN=$(xdpyinfo | grep dimensions | awk '{print $2}')
    WIDTH=$(echo $SCREEN | cut -d'x' -f1)
    HEIGHT=$(echo $SCREEN | cut -d'x' -f2)
    xdotool windowsize "$WIN_ID" $WIDTH $HEIGHT
    
    # Make it unkillable by normal means
    xdotool windowstate "$WIN_ID" "fullscreen"
}

# Infinite resurrection loop
while true; do
    if ! pgrep -f "alacritty.*--class $WINDOW_CLASS" > /dev/null; then
        launch
    fi
    sleep 1
done
