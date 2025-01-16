{ pkgs, ... }:
let
  gh-q = pkgs.stdenvNoCC.mkDerivation {
    inherit (sources.gh-q) pname src;
    dontUnpack = true;
    installPhase = ''
      runHook preInstall
      install -Dm555 "$src" "$out/bin/gh-q"
      runHook postInstall
    '';
    version = sources.gh-q.date;
  };
  sources = import ../../_sources/generated.nix {
    inherit (pkgs)
      dockerTools
      fetchFromGitHub
      fetchgit
      fetchurl
      ;
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
