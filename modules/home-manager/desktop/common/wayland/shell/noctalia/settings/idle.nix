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
    suspend = {
      action = "lock_and_suspend";
      enabled = true;
      timeout = 900;
    };
  };
  behavior_order = [
    "lock"
    "suspend"
    "screen-off"
  ];
  pre_action_fade_seconds = 2.0;
}
