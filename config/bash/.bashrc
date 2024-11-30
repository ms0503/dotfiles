[[ $- != *i* ]] && return

[[ -r $HOME/.bash_aliases ]] && . "$HOME/.bash_aliases"

[[ -r /opt/ros/humble/setup.sh ]] && . /opt/ros/humble/setup.sh

command -v pyenv &>/dev/null && alias brew='env PATH=${PATH//$(pyenv root)\/shims:/} brew'
command -v starship &>/dev/null && eval "$(starship init bash)"
