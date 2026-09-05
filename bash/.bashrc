~/.local/bin/tmux.sh
export QT_QPA_PLATFORMTHEME=qt5ct
export QT_STYLE_OVERRIDE=kvantum
set -o vi
export PATH="$HOME/.cargo/bin:/usr/lib/node_modules/.bin:$HOME/.local/bin:$HOME/.usagi/bin/:$PATH:"
export EDITOR="vim"
export TERMINAL="alacritty"
export TERM="alacritty"

alias ci3='vim ~/.config/i3/config'
alias do='v ~/Life/Rem-TODO/TODO.md'
alias ls='ls --color=auto'
alias la='ls -a'
alias surf='GDK_BACKEND=x11 surf'
alias ll='ls -la'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'
alias active='source ~/venvs/textual-dev/bin/activate'
alias life='cd ~/Life; yazi; cd - '
alias work='cd ~/Projects/; yazi; cd -' 
alias c_drive='cd ~/.var/app/ru.linux_gaming.PortProton/data/prefixes/DEFAULT/drive_c/; yazi; cd -' 
alias br='xrandr -output VGA-1 --brightness'
alias usagibook='surf ~/Documents/Books/book.usagiengine.com/index.html'
alias rd='redshift -P -O'
alias bk='groff -Tpdf test.ms > book.pdf'
alias e='emacs -nw'
alias keys='~/nehfiles/scripts/scripts/keys.sh'
alias ytshii="~/Projects/Bash/YT.sh"
alias radio='~/Projects/Bash/Radio.sh'
alias todo='glow ~/Life/Rem-TODO/TODO.md'
alias le_theme='glow ~/Documents/enterprise-black.md'
alias conv='cd ~/Projects/book/; groff -Tpdf test.ms -ms > book.pdf;zathura book.pdf; cd -'
export LS_COLORS="di=1;38;5;109:fi=0:ln=38;5;73:ex=38;5;114:*.md=38;5;189:*.txt=38;5;253:*.conf=38;5;131:*.sh=38;5;114"
# export PS1="\[\e[38;5;75m\]\u@\h \[\e[38;5;113m\]\w \[\e[38;5;189m\]\$ \[\e[0m\]"
alias v='vim'
alias k='kak'
alias m='micro'
alias h='helix'
export PATH="/home/neh-btw/AppImages:$PATH"
# export MANPAGER="sh -c 'col -bx | bat -p'"
export MANPAGER='bat'
## My bashprompt
# Minimal git-aware prompt for Enterprise Black
parse_git_branch() {
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null) || return
    if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
        echo " (${branch}*)"
    else
        echo " (${branch})"
    fi
}

export PS1="\[\e[38;5;109m\]\w\[\e[38;5;131m\]\$(parse_git_branch)\[\e[38;5;253m\] \$ \[\e[0m\]"
clear
fastfetch

# Auto-start tmux (only if not already in tmux)
