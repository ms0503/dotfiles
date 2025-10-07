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
