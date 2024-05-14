{pkgs, ...}: {
  home.packages = with pkgs; [
    curl
    du-dust
    duf
    fd
    fx
    imagemagick
    killall
    lazydocker
    lazygit
    lolcat
    neofetch
    pingu
    procs
    silicon
    speedtest-cli
    tokei
    typos
    unar
    unrar
    #unzip  # not work. why?
    wget
    zip
  ];
  programs = {
    bat.enable = true;
    bottom.enable = true;
    eza = {
      enable = true;
      extraOptions = [
        "--sort=Name"
      ];
      git = true;
      icons = true;
    };
    gpg = {
      enable = true;
      mutableKeys = true;
      mutableTrust = true;
    };
    jq.enable = true;
    ripgrep.enable = true;
  };
}
