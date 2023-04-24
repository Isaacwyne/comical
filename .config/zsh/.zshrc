# Created by newuser for 5.9
# Lines configured by zsh-newuser-install
HISTFILE=~/.config/zsh/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install

# fzf
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse \
    --prompt '∷ ' \
    --pointer ▶ \
    --marker ⇒"
export FZF_DEFAULT_COMMAND='fd --type f --no-ignore --hidden --follow'
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh

## -- ALIASES
source ~/.config/shell/aliasrc
eval "$(starship init zsh)"
