{ pkgs, ... }:
let
  gh-q = pkgs.stdenvNoCC.mkDerivation rec {
    installPhase = ''
      install -dm755 "$out/bin"
      install -Dm755 "$src/gh-q" "$out/bin/gh-q"
      sed -i 1d "$out/bin/gh-q"
      sed -i '1i#!\/usr\/bin\/env sh' "$out/bin/gh-q"
      chmod 0555 "$out/bin/gh-q"
    '';
    name = "gh-q";
    phases = [
      "installPhase"
    ];
    pname = name;
    src = pkgs.fetchFromGitHub {
      owner = "kawarimidoll";
      repo = "gh-q";
      rev = "5dc627f350902e0166016a9dd1f9479c75e3f392";
      sha256 = "A0xYze0LCA67Qmck3WXiUihchLyjbOzWNQ++mitf3bk=";
    };
  };
  userEmail = "ms0503@outlook.com";
  userName = "ms0503";
in
{
  programs = {
    gh = {
      enable = true;
      extensions = [
        gh-q
        pkgs.gh-markdown-preview
      ];
    };
    git = {
      delta = {
        enable = true;
        options = {
          line-numbers = true;
          minus-style = "syntax #330000";
          navigate = true;
          plus-style = "syntax #003300";
          side-by-side = true;
          syntax-theme = "zenburn";
        };
      };
      enable = true;
      extraConfig = {
        core.autocrlf = "input";
        init.defaultBranch = "main";
        merge.ff = "only";
        pager = {
          diff = "delta";
          log = "delta";
          reflog = "delta";
          show = "delta";
        };
        pull = {
          ff = "only";
          rebase = true;
        };
        push.gpgSign = "if-asked";
      };
      inherit userEmail userName;
      lfs.enable = true;
      signing = {
        key = "4FCF9A4478F4BB66DC7A51E348EB16DEF513A505";
        signByDefault = true;
      };
    };
    mercurial = {
      enable = true;
      inherit userEmail userName;
    };
  };
}
# vim: et sts=2 sw=2 ts=2
