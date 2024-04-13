{pkgs, ...}: {
  home.packages = with pkgs; [
    curl
    du-dust
    duf
    fd
    fx
    imagemagick
    killall
    lolcat
    neofetch
    pingu
    procs
    speedtest-cli
    tokei
    typos
    unar
    unrar
    unzip
    wget
    zip
  ];
  programs = {
    bat.enable = true;
    bottom.enable = true;
    eza = {
      enable = true;
      git = true;
      icons = true;
    };
    jq.enable = true;
    ripgrep.enable = true;
  };
}
