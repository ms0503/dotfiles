function set_win_title() {
    local DIR=$PWD
    if [[ $DIR =~ $HOME ]]; then
        DIR=${DIR#$HOME}
        DIR=~${DIR:+/}$DIR
    fi
    printf "]0; $USER@$HOSTNAME:$DIR "
}
starship_precmd_user_func=set_win_title
PATH="$HOME/bin:$HOME/.local/bin${PATH:+:}$PATH"
[[ -x /home/linuxbrew/.linuxbrew/bin/brew ]] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
if type brew &>/dev/null; then
    HOMEBREW_PREFIX="$(brew --prefix)"
    if [[ -t 1 ]]; then
        if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
            . "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
        else
            for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
                [[ -r "${COMPLETION}" ]] && . "${COMPLETION}"
            done
        fi
    fi
fi
