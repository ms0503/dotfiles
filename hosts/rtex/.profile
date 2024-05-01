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
command -v discordcanary && discordcanary &
command -v jetbrains-toolbox && jetbrains-toolbox &
command -v slack && slack &
command -v unityhub && unityhub &
