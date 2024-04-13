{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    gnupg
  ];
  programs.gnupg.agent = {
    enable = true;
    enableBrowserSocket = true;
    enableExtraSocket = true;
    enableSSHSupport = true;
  };
}
