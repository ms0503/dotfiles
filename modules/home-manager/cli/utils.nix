{
  myPkgs,
  pkgs,
  theme,
  ...
}:
{
  home.packages =
    (with pkgs; [
      aria2
      cachix
      curl
      dust
      duf
      ffmpeg-full
      file
      fx
      gemini-cli
      ghq
      imagemagick
      killall
      lazydocker
      nh
      nurl
      osslsigncode
      p7zip
      pandoc
      procs
      rcodesign
      ripunzip
      silicon
      sqlite
      tokei
      typos
      unar
      unrar
      vrc-get
      wget
      zenn-cli
      zip
    ])
    ++ (with myPkgs; [
      unzip-unicode
      zifu
    ]);
  programs = {
    bat = {
      enable = true;
      themes.tokyonight-night = {
        file = "extras/sublime/tokyonight_night.tmTheme";
        src = pkgs.fetchFromGitHub {
          owner = "folke";
          repo = "tokyonight.nvim";
          rev = "v4.11.0";
          sha256 = "pMzk1gRQFA76BCnIEGBRjJ0bQ4YOf3qecaU6Fl/nqLE=";
        };
      };
    };
    bottom.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    eza = {
      enable = true;
      extraOptions = [
        "--color=auto"
        "--sort=Name"
      ];
      git = true;
      icons = "auto";
    };
    fd.enable = true;
    fzf = {
      colors = theme.fzf;
      enable = true;
    };
    htop.enable = true;
    jq.enable = true;
    lazygit.enable = true;
    less.enable = true;
    lesspipe.enable = true;
    man = {
      enable = true;
      generateCaches = true;
    };
    ripgrep.enable = true;
    ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks."*" = {
        serverAliveCountMax = 5;
        serverAliveInterval = 60;
      };
    };
    yazi.enable = true;
    yt-dlp = {
      enable = true;
      settings = {
        downloader = "aria2c";
        downloader-args = "aria2c:'-c -x8 -s8 -k1M'";
      };
    };
  };
}
