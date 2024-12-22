# shellcheck disable=SC2034
[[ $- != *i* ]] && return

function set_win_title() {
    local DIR=$PWD
    if [[ $DIR =~ $HOME ]]; then
        DIR=${DIR#"$HOME"}
        DIR=~${DIR:+/}$DIR
    fi
    printf "]0; %s@%s:%s " "$USER" "$HOSTNAME" "$DIR"
}

if command -v starship &>/dev/null; then
    eval "$(starship init bash)"
    starship_precmd_user_func=set_win_title
fi
