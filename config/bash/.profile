[[ -d /usr/share/gem/ruby/3.3.0/bin ]] && export PATH=/usr/share/gem/ruby/3.3.0/bin${PATH:+:}$PATH

[[ -r $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh ]] && . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

if [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    HOMEBREW_PREFIX=$(brew --prefix)
    if [[ -t 1 ]]; then
        if [[ -r $HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh ]]; then
            . "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh"
        else
            for COMPLETION in "$HOMEBREW_PREFIX/etc/bash_completion.d/"*; do
                [[ -r $COMPLETION ]] && . "$COMPLETION"
            done
        fi
    fi
fi

if [[ -d $HOME/.pyenv ]]; then
    export PYENV_ROOT=$HOME/.pyenv
    export PATH=$PYENV_ROOT/bin${PATH:+:}$PATH
    command -v pyenv &>/dev/null && eval "$(pyenv init -)"
fi

if [[ -r $HOME/.cargo/env ]]; then
    . "$HOME/.cargo/env"
elif [[ -d $HOME/.cargo/bin ]]; then
    export PATH=$HOME/.cargo/bin${PATH:+:}$PATH
fi

[[ -d /usr/lib/dotnet ]] && export DOTNET_ROOT=/usr/lib/dotnet

[[ -d ${XDG_DATA_HOME:-$HOME/.local/share}/JetBrains/Toolbox/scripts ]] && export PATH=${XDG_DATA_HOME:-$HOME/.local/share}/JetBrains/Toolbox/scripts${PATH:+:}$PATH
[[ -d /usr/local/cuda/extras/CUPTI/lib64 ]] && export LD_LIBRARY_PATH=$LD_LIBRARY_PATH${LD_LIBRARY_PATH:+:}/usr/local/cuda/extras/CUPTI/lib64
[[ -d $HOME/.local/share/gem/ruby/3.3.0/bin ]] && export PATH=$HOME/.local/share/gem/ruby/3.3.0/bin${PATH:+:}$PATH
[[ -d $HOME/go/bin ]] && export PATH=$HOME/go/bin${PATH:+:}$PATH
[[ -d $HOME/.local/bin ]] && export PATH=$HOME/.local/bin${PATH:+:}$PATH
[[ -d $HOME/bin ]] && export PATH=$HOME/bin${PATH:+:}$PATH

export GLFW_IM_MODULE=ibus
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export SDL_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
