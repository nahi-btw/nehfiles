#!/bin/bash

if pgrep -x waybar > /dev/null; then
    killall waybar
else
    waybar &  # or however you normally launch polybar
fi
