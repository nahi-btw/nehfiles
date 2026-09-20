#!/bin/bash

if pgrep -x i3bar > /dev/null; then
    killall i3bar
else
    i3bar &  # or however you normally launch polybar
fi
