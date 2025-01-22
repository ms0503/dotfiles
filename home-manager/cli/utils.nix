{
  lib,
  myPkgs,
  pkgs,
  ...
}:
let
  sources = import ../../_sources/generated.nix {
    inherit (pkgs)
      dockerTools
      fetchFromGitHub
      fetchgit
      fetchurl
      ;
  };
  tokyo-night-yazi = pkgs.stdenvNoCC.mkDerivation {
    inherit (sources.tokyo-night-yazi) pname src;
    installPhase = ''
      runHook preInstall
      install -Dm444 -t "$out" \
        "$src/LICENSE" \
        "$src/LICENSE-tmtheme" \
        "$src/README.md" \
        "$src/flavor.toml" \
        "$src/preview.png" \
        "$src/tmtheme.xml"
      runHook postInstall
    '';
    version = sources.tokyo-night-yazi.date;
  };
in
{
  home.packages =
    (with pkgs; [
      aria2
      cachix
      curl
      du-dust
      duf
      ffmpeg-full
      file
      fx
      ghq
      imagemagick
      killall
      lazydocker
      nh
      nurl
      p7zip
      procs
      ripunzip
      silicon
      sqlite
      tokei
      typos
      unar
      unrar
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
      #colors = "auto";
      enable = true;
      extraOptions = [
        "--color=auto"
        "--sort=Name"
      ];
      git = true;
      icons = "auto";
    };
    fd.enable = true;
    fzf.enable = true;
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
      extraConfig = lib.mkDefault "";
      serverAliveCountMax = 5;
      serverAliveInterval = 60;
    };
    yazi = {
      enable = true;
      flavors = {
        tokyo-night = tokyo-night-yazi;
      };
    };
    yt-dlp = {
      enable = true;
      settings = {
        downloader = "aria2c";
        downloader-args = "aria2c:'-c -x8 -s8 -k1M'";
      };
    };
  };
}
