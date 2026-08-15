#!/bin/bash
# rest.sh — cool down, screen off, save battery, no suspend

# 1. Cap CPU to minimum, powersave governor
sudo cpupower frequency-set -g powersave
sudo cpupower frequency-set -u 800MHz

# 2. Freeze background user processes (not the compositor itself, or screen-off won't work)
echo 1 | sudo tee /sys/fs/cgroup/user.slice/user-$(id -u).slice/cgroup.freeze 2>/dev/null

# 3. Turn off screen (Niri via DPMS)
niri msg action power-off-monitors

# 4. Optional: drop WiFi power if you don't need it
sudo iw dev wlp4s0 set power_save on
