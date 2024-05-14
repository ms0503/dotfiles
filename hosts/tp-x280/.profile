[[ -x /home/linuxbrew/.linuxbrew/bin/brew ]] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
if [[ -d $HOME/.pyenv ]]; then
    PYENV_ROOT=$HOME/.pyenv
    PATH=$PYENV_ROOT/bin:$PATH
    export PATH PYENV_ROOT
    command -v pyenv &>/dev/null && eval "$(pyenv init -)"
fi
[[ -d ${HOME}/.local/bin ]] && export PATH=${HOME}/.local/bin${PATH:+:}${PATH}
[[ -d ${HOME}/bin ]] && export PATH=${HOME}/bin${PATH:+:}${PATH}
[[ -r "${HOME}/.cargo/env" ]] && . "${HOME}/.cargo/env"
