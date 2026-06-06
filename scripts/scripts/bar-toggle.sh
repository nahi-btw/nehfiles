#!/bin/bash

if pgrep -x polybar > /dev/null; then
    killall polybar
else
    polybar &  # or however you normally launch polybar
fi
