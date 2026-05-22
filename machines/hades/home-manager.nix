{
  home.packages = [ ];
  imports = [ ];
  programs.ssh.settings.github = {
    HostName = "github.com";
    IdentityFile = "~/.ssh/github";
    User = "git";
  };
}
