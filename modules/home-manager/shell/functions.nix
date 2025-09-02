''
  fzcd() {
    local path="$(fzf --walker dir,follow,hidden || :)"
    [[ -n $path ]] && cd "$path" || :
  }

  gfzcd() {
    local path="$(dir=$(ghq list | fzf || :); [[ -n $dir ]] && echo "$(ghq root)/$dir" || :)"
    [[ -n $path ]] && cd "$path" || :
  }
''
