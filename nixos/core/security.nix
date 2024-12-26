{ pkgs, ... }:
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
  security.sudo.wheelNeedsPassword = false;
}
# vim: et sts=2 sw=2 ts=2
