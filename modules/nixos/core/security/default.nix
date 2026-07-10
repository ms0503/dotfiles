{ pkgs, username, ... }:
{
  environment.systemPackages = with pkgs; [
    libfido2
  ];
  programs.gnupg = {
    agent = {
      enable = true;
      enableBrowserSocket = true;
      enableExtraSocket = true;
      enableSSHSupport = true;
    };
    dirmngr.enable = true;
  };
  security = {
    sudo.enable = false;
    sudo-rs = {
      enable = true;
      wheelNeedsPassword = false;
    };
  };
  services.udev.packages = [
    (pkgs.callPackage ./udev-rules.nix { })
  ];
  users = {
    groups.plugdev = { };
    users."${username}".extraGroups = [
      "plugdev"
    ];
  };
}
