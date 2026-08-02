args:
let
  categories = [
    "accessibility"
    "audio"
    "bar"
    "battery"
    "brightness"
    "calendar"
    "control_center"
    "dock"
    "hooks"
    "idle"
    "keybinds"
    "location"
    "lockscreen"
    "lockscreen_widgets"
    "nightlight"
    "notification"
    "osd"
    "shell"
    "storage"
    "system"
    "theme"
    "wallpaper"
    "weather"
    "widget"
  ];
in
categories
|> builtins.map (cat: {
  name = cat;
  value = import ./${cat}.nix args;
})
|> builtins.listToAttrs
