{
  display = {
    color = {
      keys = "cyan";
      output = "green";
      separator = "white";
      title = "blue";
    };
    key.type = "both";
    separator = ": ";
  };
  logo = {
    padding = {
      bottom = 0;
      left = 0;
      right = 4;
      top = 0;
    };
    position = "left";
    source = "NixOS2";
    type = "builtin";
  };
  modules = [
    {
      fqdn = false;
      key = "You";
      keyIcon = "";
      type = "title";
    }
    {
      keyIcon = "";
      type = "uptime";
    }
    {
      keyIcon = "";
      type = "locale";
    }
    {
      keyIcon = "";
      type = "shell";
    }
    {
      keyIcon = "󰓸";
      type = "wmtheme";
    }
    {
      keyIcon = "󰉼";
      type = "theme";
    }
    {
      keyIcon = "";
      type = "icons";
    }
    {
      keyIcon = "";
      type = "font";
    }
    {
      keyIcon = "󰆿";
      type = "cursor";
    }
    {
      keyIcon = "";
      type = "terminal";
    }
    {
      keyIcon = "";
      type = "terminalfont";
    }
    {
      keyIcon = "󰔎";
      type = "terminaltheme";
    }
    {
      keyIcon = "󱞎";
      type = "editor";
    }
    {
      outputColor = "white";
      string = "=";
      times = 0;
      type = "separator";
    }
    {
      keyIcon = "";
      type = "os";
    }
    {
      keyIcon = "";
      type = "kernel";
    }
    {
      keyIcon = "󰿄";
      type = "initsystem";
    }
    {
      combined = false;
      keyIcon = "󰏖";
      type = "packages";
    }
    {
      keyIcon = "󰧨";
      type = "lm";
    }
    {
      keyIcon = "";
      type = "de";
    }
    {
      detectPlugin = true;
      keyIcon = "";
      type = "wm";
    }
    {
      outputColor = "white";
      string = "=";
      times = 0;
      type = "separator";
    }
    {
      keyIcon = "󰌢";
      type = "host";
    }
    {
      keyIcon = "";
      type = "bios";
    }
    {
      keyIcon = "";
      type = "bootmgr";
    }
    {
      compactType = "none";
      keyIcon = "󰍹";
      preciseRefreshRate = false;
      type = "display";
    }
    {
      keyIcon = "";
      type = "chassis";
    }
    {
      keyIcon = "";
      type = "board";
    }
    {
      keyIcon = "";
      type = "tpm";
    }
    {
      keyIcon = "";
      showPeCoreCount = true;
      temp = true;
      type = "cpu";
    }
    {
      keyIcon = "";
      type = "cpucache";
    }
    {
      keyIcon = "󰓅";
      type = "cpuusage";
    }
    {
      detectionMethod = "pci";
      driverSpecific = true;
      hideType = "none";
      keyIcon = "󰾲";
      percent = {
        green = 50;
        type = 11; # colored number(8) | show bar(2) | show number(1)
        yellow = 80;
      };
      temp = true;
      type = "gpu";
    }
    {
      keyIcon = "";
      percent = {
        green = 50;
        type = 11; # colored number(8) | show bar(2) | show number(1)
        yellow = 80;
      };
      type = "memory";
    }
    {
      keyIcon = "󰓡";
      percent = {
        green = 50;
        type = 11; # colored number(8) | show bar(2) | show number(1)
        yellow = 80;
      };
      separate = true;
      type = "swap";
    }
    {
      keyIcon = "󰋊";
      temp = true;
      type = "physicaldisk";
    }
    {
      folders = "";
      hideFS = "";
      hideFolders = "/boot";
      keyIcon = "";
      percent = {
        green = 50;
        type = 11; # colored number(8) | show bar(2) | show number(1)
        yellow = 80;
      };
      showExternal = true;
      showHidden = true;
      showReadOnly = true;
      showRegular = true;
      showSubvolumes = false;
      showUnknown = true;
      useAvailable = false;
      type = "disk";
    }
    {
      keyIcon = "";
      percent = {
        green = 50;
        type = 11; # colored number(8) | show bar(2) | show number(1)
        yellow = 80;
      };
      temp = true;
      type = "battery";
    }
    {
      keyIcon = "󰚥";
      type = "poweradapter";
    }
    {
      keyIcon = "󰩠";
      timeout = 5000;
      type = "publicip";
    }
    {
      compact = false;
      defaultRouteOnly = false;
      keyIcon = "󰩟";
      namePrefix = "";
      showAllIps = true;
      showFlags = false;
      showIpv4 = true;
      showIpv6 = true;
      showLoop = true;
      showMac = true;
      showMtu = false;
      showPrefixLen = true;
      showSpeed = true;
      type = "localip";
    }
    {
      keyIcon = "󰇖";
      type = "dns";
    }
    {
      keyIcon = "";
      type = "wifi";
    }
    {
      keyIcon = "󰂯";
      type = "bluetooth";
    }
    {
      keyIcon = "󰐻";
      type = "bluetoothradio";
    }
    {
      keyIcon = "";
      type = "sound";
    }
    {
      keyIcon = "󰄀";
      type = "camera";
    }
    {
      keyIcon = "";
      type = "keyboard";
    }
    {
      keyIcon = "󰍽";
      type = "mouse";
    }
    {
      keyIcon = "󰺵";
      type = "gamepad";
    }
    {
      outputColor = "white";
      string = "=";
      times = 0;
      type = "separator";
    }
    {
      keyIcon = "";
      type = "opencl";
    }
    {
      keyIcon = "";
      type = "opengl";
    }
    {
      keyIcon = "";
      type = "vulkan";
    }
    {
      outputColor = "white";
      string = "=";
      times = 0;
      type = "separator";
    }
    {
      keyIcon = "󰾆";
      type = "netio";
    }
    {
      keyIcon = "󰓅";
      type = "diskio";
    }
    {
      outputColor = "white";
      string = "=";
      times = 0;
      type = "separator";
    }
    {
      keyIcon = "";
      type = "version";
    }
    "break"
    {
      block = {
        range = [
          0
          15
        ];
        width = 3;
      };
      brightness = "default";
      key = " ";
      keyIcon = "";
      paddingLeft = 0;
      symbol = "block";
      type = "colors";
    }
  ];
}
