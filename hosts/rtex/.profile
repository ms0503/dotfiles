if [[ -d ${HOME}/.pyenv ]]; then
    PYENV_ROOT=${HOME}/.pyenv
    PATH=${PYENV_ROOT}/bin${PATH:+:}${PATH}
    export PATH PYENV_ROOT
    command -v pyenv &>/dev/null && eval "$(pyenv init -)"
fi
[[ -d /usr/local/cuda/extras/CUPTI/lib64 ]] && export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}${LD_LIBRARY_PATH:+:}/usr/local/cuda/extras/CUPTI/lib64
[[ -d ${HOME}/.local/bin ]] && export PATH=${HOME}/.local/bin${PATH:+:}${PATH}
[[ -d ${HOME}/bin ]] && export PATH=${HOME}/bin${PATH:+:}${PATH}
