#!/bin/bash
# wake.sh
echo 0 | sudo tee /sys/fs/cgroup/user.slice/user-$(id -u).slice/cgroup.freeze
sudo cpupower frequency-set -g schedutil
sudo cpupower frequency-set -u 2700MHz   # or whatever your max is
niri msg action power-on-monitors
