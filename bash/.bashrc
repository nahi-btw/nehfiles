# ~/.bashrc
#
# If not running interactively, don't do anything
set -o vi
export BROWSER="Firefox"
[[ $- != *i* ]] && return
export EDITOR="vim"
export VISUAL="$EDITOR"
alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
export PATH="$HOME/.local/bin:$PATH:$HOME/.cargo/bin"
alias shb="shellbeats"
alias chatgpt="surf chatgpt.com &"
alias jfi='carbonyl https://lofiradio24.com/radio/jazzhop'
alias nv='nvim'
alias v='vim'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias cdwm="vim ~/suckless/dwm/config.h"
alias mdwm="cd ~/suckless/dwm; sudo make clean install;cd -"
alias pdf="zathura"
alias py="python3"
alias rd="redshift -P -O"
alias ci3="vim ~/.config/i3/config"
# . "$HOME/.cargo/env"
export PATH="$PATH:/home/neh-btw/scripts/"
# fastfetch
## The Prompt
PS1='\[\e[38;2;137;180;250m\]\W\[\e[38;2;108;112;134m\] ❯\[\e[0m\] '
