{
  config,
  lib,
  myLib,
  myPkgs,
  pkgs,
  theme,
  ...
}:
let
  inherit (config.ms0503) feature-set;
  inherit (lib) optionalAttrs optionals;
  inherit (myLib) const;
in
{
  home.packages =
    (with pkgs; [
      cachix
      curl
      dust
      duf
      file
      ghq
      killall
      nh
      nurl
      p7zip
      pandoc
      procs
      ripunzip
      sqlite
      tokei
      typos
      unar
      unrar
      wget
      zip
    ])
    ++ (with myPkgs; [
      unzip-unicode
      zifu
    ])
    ++ optionals (const.feature-sets.lite <= feature-set) (
      with pkgs;
      [
        (if (const.feature-sets.full <= feature-set) then ffmpeg-full else ffmpeg)
        aria2
        fx
        imagemagick
        osslsigncode
        rcodesign
        vrc-get
      ]
    )
    ++ optionals (const.feature-sets.full <= feature-set) (
      with pkgs;
      [
        gemini-cli
        lazydocker
        silicon
        zenn-cli
      ]
    );
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
  }
  // optionalAttrs (const.feature-sets.lite <= feature-set) {
    lazygit.enable = true;
    yt-dlp = {
      enable = true;
      settings = {
        downloader = "aria2c";
        downloader-args = "aria2c:'-c -x8 -s8 -k1M'";
      };
    };
  };
}
