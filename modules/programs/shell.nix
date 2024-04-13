{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    acpi
    bottom
    btrfs-progs
    duf
    lsof
    pciutils
  ];
  programs = {
    git.enable = true;
    neovim = {
      defaultEditor = true;
      enable = true;
      viAlias = true;
      vimAlias = true;
      withNodeJs = true;
      withPython3 = true;
      withRuby = true;
    };
  };
}
