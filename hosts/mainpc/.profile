[[ -x /home/linuxbrew/.linuxbrew/bin/brew ]] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
if [[ -d ${HOME}/.pyenv ]]; then
    PYENV_ROOT=${HOME}/.pyenv
    PATH=${PYENV_ROOT}/bin${PATH:+:}${PATH}
    export PATH PYENV_ROOT
    command -v pyenv &>/dev/null && eval "$(pyenv init -)"
fi
[[ -d ${XDG_DATA_HOME:-${HOME}/.local/share}/JetBrains/Toolbox/scripts ]] && PATH=${XDG_DATA_HOME:-${HOME}/.local/share}/JetBrains/Toolbox/scripts${PATH:+:}${PATH}
[[ -d /usr/local/cuda/extras/CUPTI/lib64 ]] && export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}${LD_LIBRARY_PATH:+:}/usr/local/cuda/extras/CUPTI/lib64
[[ -d ${HOME}/.local/bin ]] && export PATH=${HOME}/.local/bin${PATH:+:}${PATH}
[[ -d ${HOME}/bin ]] && export PATH=${HOME}/bin${PATH:+:}${PATH}
[[ -r "${HOME}/.cargo/env" ]] && . "${HOME}/.cargo/env"
export DOTNET_ROOT=/usr/lib/dotnet
