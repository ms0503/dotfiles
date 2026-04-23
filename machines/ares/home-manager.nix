{
  home.packages = [ ];
  imports = [ ];
  programs.ssh.extraConfig = ''
    Host github github.com
      HostName github.com
      IdentityFile ~/.ssh/github
      User git
  '';
}
