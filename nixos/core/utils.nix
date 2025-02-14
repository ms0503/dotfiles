{
  inputs',
  myPkgs,
  pkgs,
  ...
}:
{
  environment.systemPackages =
    [
      (inputs'.neovim-custom.packages.default.override {
        viAlias = true;
        vimAlias = true;
      })
    ]
    ++ (with pkgs; [
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
    udev.extraRules = ''
      ENV{UDISKS_AUTO}="1"
    '';
    udisks2 = {
      enable = true;
      mountOnMedia = true;
    };
  };
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
}
