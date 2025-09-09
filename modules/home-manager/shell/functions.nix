''
  fzcd() {
    local p="$(fzf --walker dir,follow,hidden || :)"
    [[ -n $p ]] && cd "$p" || :
  }

  gfzcd() {
    local p="$(dir=$(ghq list | fzf || :); [[ -n $dir ]] && echo "$(ghq root)/$dir" || :)"
    [[ -n $p ]] && cd "$p" || :
  }
''
