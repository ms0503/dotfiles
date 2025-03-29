{
  myPkgs,
  pkgs,
  ...
}:
{
  environment.systemPackages =
    (with pkgs; [
      acpi
      bash
      bat
      bottom
      btrfs-progs
      du-dust
      duf
      eza
      fd
      file
      fzf
      jq
      libinput-gestures
      lsof
      man
      pciutils
      procs
      ripgrep
      sl
      tokei
      unar
      unrar
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
    htop.enable = true;
    less.enable = true;
    yazi.enable = true;
  };
  services = {
    fwupd.enable = true;
    libinput.enable = true;
    openssh = {
      allowSFTP = true;
      enable = true;
    };
    udev = {
      extraRules = ''
        ENV{UDISKS_AUTO}="1"
      '';
      packages = with pkgs; [
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
    virtualbox.host = {
      addNetworkInterface = false;
      enable = true;
      enableExtensionPack = true;
      enableKvm = true;
    };
  };
}
