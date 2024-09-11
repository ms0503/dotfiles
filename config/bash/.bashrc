[[ -r $HOME/.bash_aliases ]] && . "$HOME/.bash_aliases"
command -v pyenv &>/dev/null && alias brew='env PATH=${PATH//$(pyenv root)\/shims:/} brew'
command -v starship &>/dev/null && eval "$(starship init bash)"
