#!/bin/bash
# Enterprise Black launcher — apps ($PATH via bemenu-run) + .desktop entries (via j4-dmenu-desktop)
BEMENU_OPTS="--fn 'JetBrainsMono Nerd Font 12' --tb '#0a0a0ad9' --tf '#e9e9e9' --fb '#0a0a0ad9' --ff '#e9e9e9' --hb '#557b93' --hf '#0a0a0aff' --nb '#0a0a0ad9' --nf '#e9e9e9' --ab '#0a0a0ad9' --af '#5a5a5a' --scb '#0197bb' --scf '#0a0a0a' -i -l 10"
j4-dmenu-desktop --dmenu="bemenu $BEMENU_OPTS -p 'Launch:'" --no-generic
