PYENV_ROOT=$HOME/.pyenv
PATH=$PYENV_ROOT/bin:$PATH
export PATH PYENV_ROOT
if command -v pyenv &>/dev/null; then
    eval "$(pyenv init -)"
fi
