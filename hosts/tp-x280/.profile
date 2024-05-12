[[ -x /home/linuxbrew/.linuxbrew/bin/brew ]] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
if [[ -d $HOME/.pyenv ]]; then
    PYENV_ROOT=$HOME/.pyenv
    PATH=$PYENV_ROOT/bin:$PATH
    export PATH PYENV_ROOT
    command -v pyenv &>/dev/null && eval "$(pyenv init -)"
fi
