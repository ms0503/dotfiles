{ pkgs, ... }:
{
  home = {
    packages = [ ];
    pointerCursor = {
      gtk.enable = true;
      name = "Milk1";
      package = pkgs.milk-cursor-themes;
      size = 32;
      x11.enable = true;
    };
    sessionVariables = {
      HYPRCURSOR_SIZE = "32";
      HYPRCURSOR_THEME = "Milk1";
    };
  };
  imports = [ ];
  programs.ssh.extraConfig = ''
    Host github github.com
      HostName github.com
      IdentityFile ~/.ssh/github
      User git
  '';
}
