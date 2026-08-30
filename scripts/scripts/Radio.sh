#!/bin/bash
declare -A urls=(
    [BossaNova]="https://www.1.fm/tunestream/bossanova/listen.pls"
    [Lofi]="https://play.streamafrica.net/lofiradio"
    [Jazz]="https://stream.zeno.fm/00rt0rdm7k8uv"
    [Downtempo]="http://api.somafm.com/groovesalad.pls"
    [Fusion]="https://listen.181fm.com/181-fusionjazz_128k.mp3"
)

read -p "which stream?
1. Downtempo
2. Jazz
3. Fusion
4. BossaNova
5. Lofi
:- " name

if [[ -n "${urls[$name]}" ]]; then
    mpv "${urls[$name]}"

else
    echo "Unknown key: $name"
    echo "Available: ${!urls[@]}"
fi
