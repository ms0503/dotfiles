{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    acpi
    bash
    bat
    bottom
    btrfs-progs
    du-dust
    duf
    eza
    fd
    fzf
    jq
    lsof
    man
    pciutils
    procs
    ripgrep
    sl
    tokei
    unar
    unrar
    unzip
    zip
  ];
  programs = {
    git.enable = true;
    htop.enable = true;
    less.enable = true;
    neovim = {
      defaultEditor = true;
      enable = true;
      viAlias = true;
      vimAlias = true;
    };
    yazi.enable = true;
  };
}
# vim: et sts=2 sw=2 ts=2
