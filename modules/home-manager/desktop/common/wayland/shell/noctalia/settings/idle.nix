_: {
  behavior = {
    lock = {
      action = "lock";
      enabled = true;
      timeout = 600;
    };
    screen-off = {
      action = "screen_off";
      enabled = true;
      timeout = 660;
    };
  };
  behavior_order = [
    "lock"
    "screen-off"
  ];
  pre_action_fade_seconds = 2.0;
}
