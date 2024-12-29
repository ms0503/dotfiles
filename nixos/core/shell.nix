{ inputs, pkgs, ... }:
let
  myPkgs = inputs.self.outputs.packages.${pkgs.system};
in
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
