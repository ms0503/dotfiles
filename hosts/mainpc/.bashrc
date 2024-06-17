if command -v pyenv &>/dev/null; then
    alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'
fi
