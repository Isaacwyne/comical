## FUNCTIONS  -------------------------------------- ##
ex () {
  if [ -f "$1" ] ; then
    case $1 in
      *.tar.bz2)   tar xjf "$1"   ;;
      *.tar.gz)    tar xzf "$1"   ;;
      *.bz2)       bunzip2 "$1"   ;;
      *.rar)       unrar x "$1"   ;;
      *.gz)        gunzip "$1"    ;;
      *.tar)       tar xf "$1"    ;;
      *.tbz2)      tar xjf "$1"   ;;
      *.tgz)       tar xzf "$1"   ;;
      *.zip)       unzip "$1"     ;;
      *.Z)         uncompress "$1";;
      *.7z)        7z x "$1"      ;;
      *.deb)       ar x "$1"      ;;
      *.tar.xz)    tar xf "$1"    ;;
      *.tar.zst)   tar xf "$1"    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

function ranger {
    local IFS=$'\t\n'
    local tempfile="$(mktemp -t tmp.XXXXXX)"
    local ranger_cmd=(
        command
        ranger
        --cmd="map Q chain shell echo %d > "$tempfile"; quitall"
    )

    ${ranger_cmd[@]} "$@"
    if [[ -f "$tempfile" ]] && [[ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]]; then
        cd -- "$(cat "$tempfile")" || return
    fi
    command rm -f -- "$tempfile 2>/dev/null"
}

vo() {
    vim "$(which "$1")"
}

yta() {
    yt-dlp --extract-audio --audio-format mp3 -o "$HOME/music/%(title)s.%(ext)s" "$@"
}

ytv() {
        yt-dlp "$@"
}

# FZF
fo() {
    IFS=$'\n' out=("$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)")
    key=$(head -1 <<< "$out")
    file=$(head -2 <<< "$out" | tail -1)
    if [ -n "$file" ]; then
        [ "$key" = ctrl-o ] && xdg-open "$file" || ${EDITOR:-vim} "$file"
    fi
}

ffvid() {
    if [ -n "$1" ]; then
        vid="$1"
        ffmpeg -i "$vid" -f mp3 -vn -ac 2 "${vid%.*}.mp3"
    else
        echo "Please supply a video file"
    fi
}

ffcut() {
    ffmpeg -i $1 -ss $3 -to $4 -c:a copy $2
}

# FZF
# change the default completion "path" to only complete files, and not files and dirs
_fzf_compgen_path() {
    rg --files --glob "!.git" . "$1"
}
_fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
}
_fzf_complete_git() {
    _fzf_complete -- "$@" < <(
        git --help -a | grep -E '^\s+' | awk '{print $1}'
    )
}
_fzf_comprun() {
    local command=$1
    shift

    case "$command" in
        git)
            _fzf_complete_git ;;
        *)
            fzf "$@" ;;
    esac
}

# better autocd
silence_autocd() {
    exec {BASH_XTRACEFD}>/dev/null
}
silence_autocd

unsilence_autocd() {
    exec {BASH_XTRACEFD}>/dev/stdout
}

function set() {
    # if calling "set -x", undo the silencing of autocd
    if [[ "$#" == 1 && "$1" == "-x" ]]; then
        command set -x;
        unsilence_autocd;
    elif [[ "$#" == 1 && "$1" == "+x" ]]; then
        silence_autocd;
        command set +x;
    else
        command set "$@";
    fi;
}

function mkcd() {
    local target="$1"
    mkdir -p "$target"
    cd "$target"
}
