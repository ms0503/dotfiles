{pkgs, ...}: let
  gh-q = pkgs.stdenv.mkDerivation rec {
    installPhase = ''
      mkdir -p $out/bin
      sed 1d $src/gh-q > $out/bin/gh-q
      sed -i "1i#!\/usr\/bin\/env sh" $out/bin/gh-q
      chmod +x $out/bin/gh-q
    '';
    name = "gh-q";
    phases = [
      "installPhase"
    ];
    pname = name;
    src = pkgs.fetchFromGitHub {
      hash = "sha256-A0xYze0LCA67Qmck3WXiUihchLyjbOzWNQ++mitf3bk=";
      owner = "kawarimidoll";
      repo = "gh-q";
      rev = "5dc627f350902e0166016a9dd1f9479c75e3f392";
    };
  };
in {
  programs = {
    gh = {
      enable = true;
      extensions = [
        gh-q
        pkgs.gh-markdown-preview
      ];
    };
    git = {
      delta.enable = true;
      enable = true;
      extraConfig = {
        init.defaultBranch = "main";
        pull = {
          ff = "only";
          rebase = true;
        };
        push.gpgSign = "if-asked";
      };
      lfs.enable = true;
      signing = {
        key = "4FCF9A4478F4BB66DC7A51E348EB16DEF513A505";
        signByDefault = true;
      };
      userEmail = "ms0503@outlook.com";
      userName = "Sora Tonami";
    };
  };
}
