[[ $- != *i* ]] && return

function set_win_title() {
    local DIR=$PWD
    if [[ $DIR =~ $HOME ]]; then
        DIR=${DIR#"$HOME"}
        DIR=~${DIR:+/}$DIR
    fi
    printf "]0; %s@%s:%s " "$USER" "$HOSTNAME" "$DIR"
}

[[ -r $HOME/.bash_aliases ]] && . "$HOME/.bash_aliases"

[[ -r /opt/ros/humble/setup.sh ]] && . /opt/ros/humble/setup.sh

command -v pyenv &>/dev/null && alias brew='env PATH=${PATH//$(pyenv root)\/shims:/} brew'
if command -v starship &>/dev/null; then
    eval "$(starship init bash)"
    starship_precmd_user_func=set_win_title
fi
