{ runCommand }:
runCommand "udev-extra-rules" { } ''
  install -Dm444 \
    "${./60-openocd.rules}" \
    "$out/lib/udev/rules.d/60-openocd.rules"
''
