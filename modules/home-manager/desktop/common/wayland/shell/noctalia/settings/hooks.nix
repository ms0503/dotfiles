{ inputs', ... }: {
  started = [
    "uwsm app -- fcitx5 -D"
    "uwsm app -- steam -silent"
  ];
  theme_mode_changed = [
    "${inputs'.noctalia.packages.default}/share/noctalia/assets/templates/gtk/apply.sh --appearance-only $NOCTALIA_THEME_MODE"
  ];
}
