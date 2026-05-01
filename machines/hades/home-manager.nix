{
  home.packages = [ ];
  imports = [ ];
  programs.ssh.matchBlocks.github = {
    hostname = "github.com";
    identityFile = "~/.ssh/github";
    user = "git";
  };
}
