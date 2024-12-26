{ inputs, pkgs, ... }:
let
  myPkgs = inputs.self.outputs.packages.${pkgs.system};
  tokyo-night-yazi = pkgs.stdenvNoCC.mkDerivation {
    installPhase = ''
      cd "$src"
      install -Dm444 -t "$out" \
        LICENSE \
        LICENSE-tmtheme \
        README.md \
        flavor.toml \
        preview.png \
        tmtheme.xml
    '';
    phases = [
      "installPhase"
    ];
    pname = "tokyo-night-yazi";
    src = pkgs.fetchFromGitHub {
      owner = "BennyOe";
      repo = "tokyo-night.yazi";
      rev = "024fb096821e7d2f9d09a338f088918d8cfadf34";
      sha256 = "IhCwP5v0qbuanjfMRbk/Uatu31rPNVChJn5Y9c5KWYQ=";
    };
    version = "latest";
  };
in
{
  home.packages =
    (with pkgs; [
      du-dust
      duf
      fx
      ghq
      imagemagick
      killall
      lazydocker
      nh
      nurl
      procs
      silicon
      sl
      tokei
      typos
      unar
      unrar
      unzip
      zenn-cli
      zip
    ])
    ++ (with myPkgs; [
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
# vim: et sts=2 sw=2 ts=2
