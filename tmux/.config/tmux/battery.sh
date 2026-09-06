#!/bin/sh

# battery.sh - Display battery percentage and status for tmux status bar
# Works with /sys/class/power_supply/ (standard Linux kernel interface)

# Find the battery directory
BATTERY_PATH=""
for possible in /sys/class/power_supply/BAT* /sys/class/power_supply/battery; do
    if [ -d "$possible" ] && [ -f "$possible/uevent" ]; then
        BATTERY_PATH="$possible"
        break
    fi
done

# If no battery found, show nothing
if [ -z "$BATTERY_PATH" ]; then
    echo ""
    exit 0
fi

# Read battery status and capacity
STATUS=$(cat "$BATTERY_PATH/status" 2>/dev/null)
CAPACITY=$(cat "$BATTERY_PATH/capacity" 2>/dev/null)

# If we can't read capacity, show nothing
if [ -z "$CAPACITY" ]; then
    echo ""
    exit 0
fi

# Determine icon and color based on status and capacity
case "$STATUS" in
    "Charging")
        ICON="⚡"
        COLOR="#[fg=green]"
        ;;
    "Discharging")
        if [ "$CAPACITY" -ge 80 ]; then
            ICON="🔋"
            COLOR="#[fg=green]"
        elif [ "$CAPACITY" -ge 50 ]; then
            ICON="🔋"
            COLOR="#[fg=yellow]"
        elif [ "$CAPACITY" -ge 20 ]; then
            ICON="🔋"
            COLOR="#[fg=orange]"
        else
            ICON="⚠️"
            COLOR="#[fg=red]"
        fi
        ;;
    "Full")
        ICON="✅"
        COLOR="#[fg=green]"
        ;;
    *)
        ICON="?"
        COLOR="#[fg=white]"
        ;;
esac

# Display the battery info
echo "${COLOR}${ICON} ${CAPACITY}%#[default]"
