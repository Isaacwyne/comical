# if not running interactively, don't do anything
[[ $- != *i* ]] && return

shopt -s autocd
shopt -s checkwinsize
shopt -s cmdhist
shopt -s dotglob
shopt -s expand_aliases
shopt -s extglob
shopt -s globstar
shopt -s histappend
shopt -s nullglob
# history file settings
HISTCONTROL=ignoreboth:erasedups
# set history size and length
HISTSIZE=5000
HISTFILESIZE=10000

set -o interactive-comments -o emacs

# shell completion
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# setting directory colors
test -r ~/.config/shell/dircolors && eval "$(dircolors -b ~/.config/shell/dircolors)" || eval "$(dircolors -b)"

# export the local bin directory
if ! [[ $PATH =~ "$HOME/.local/bin" ]]; then
    PATH="$HOME/.local/bin:$PATH"
fi

## -- ALIASES
source ~/.config/shell/aliasrc

export LESS_TERMCAP_md=$'\E[1;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_so=$'\E[1;33m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_us=$'\E[1;32m'

PS1='[\u@\h \W]\$ '

# starship prompt
eval "$(starship init bash)"

# fzf
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'
export FZF_DEFAULT_COMMAND='fd --type f --no-ignore --hidden --follow'
source /usr/share/fzf/completion.bash
source /usr/share/fzf/key-bindings.bash

neofetch
