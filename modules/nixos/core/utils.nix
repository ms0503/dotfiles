{
  config,
  lib,
  myPkgs,
  pkgs,
  ...
}:
let
  inherit (lib) optionalAttrs;
  cfgWsl = config.ms0503.wsl;
in
{
  environment.systemPackages =
    (with pkgs; [
      acpi
      bash
      bat
      btop
      btrfs-progs
      ccid
      dust
      duf
      eza
      fd
      file
      fzf
      jq
      libinput-gestures
      lsof
      man
      man-pages
      man-pages-posix
      opensc
      pciutils
      pcsc-tools
      procs
      ripgrep
      sl
      stdmanpages
      tokei
      unar
      unrar
      usbutils
      zip
    ])
    ++ (with myPkgs; [
      unzip-unicode
    ]);
  ms0503.neovim = {
    defaultEditor = true;
    enable = true;
    viAlias = true;
    vimAlias = true;
  };
  programs = {
    git.enable = true;
    less.enable = true;
    yazi.enable = true;
    zsh = {
      autosuggestions = {
        async = true;
        enable = true;
      };
      enable = true;
      enableBashCompletion = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
    };
  };
  services = {
    fwupd.enable = !cfgWsl.enable;
    libinput.enable = true;
    openssh = {
      allowSFTP = true;
      enable = true;
    };
    pcscd.enable = true;
    udev = {
      extraRules = ''
        ENV{UDISKS_AUTO}="1"

        # PaSoRi SC-S380
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="06c1", MODE="0666"
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="06c3", MODE="0666"
      '';
      packages = with myPkgs; [
        platformio-core.udev
      ];
    };
    udisks2 = {
      enable = true;
      mountOnMedia = true;
    };
  };
  virtualisation = {
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  }
  // optionalAttrs (!cfgWsl.enable) {
    virtualbox.host = {
      addNetworkInterface = false;
      enable = true;
      enableExtensionPack = true;
      enableKvm = true;
    };
  };
}
