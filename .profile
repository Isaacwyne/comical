# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . $HOME/.bashrc
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

# XDG Base directories
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}
export XDG_STATE_HOME=${XDG_STATE_HOME:="$HOME/.local/state"}

export ANDROID_HOME="$XDG_DATA_HOME"/android
export HISTFILE="${XDG_STATE_HOME}"/bash/history
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export LESSHISTFILE="$XDG_STATE_HOME"/less/history
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
# export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority

export BROWSER="brave"
export EDITOR="vim"
export READER="zathura"
export TERMINAL="alacritty"
export VISUAL="vim"

. "$CARGO_HOME/env"

PATH=/home/xarc/.cargo/bin:/home/xarc/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/opt/android-sdk/platform-tools:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/xarc/.config/bspwm/bin:/opt/android-sdk/platform-tools:/home/xarc/.config/rofi/scripts

# MPD daemon start (if no other user instance exists)
[ ! -s ~/.config/mpd/pid ] && mpd
