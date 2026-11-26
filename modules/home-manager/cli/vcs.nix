{
  config,
  myPkgs,
  pkgs,
  ...
}:
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
  sources = import ../../../_sources/generated.nix {
    inherit (pkgs)
      dockerTools
      fetchFromGitHub
      fetchgit
      fetchurl
      ;
  };
  userEmail = "admin@ms0503.dev";
  userName = "Sora Tonami";
in
{
  home.packages = with myPkgs; [
    git-vrc
  ];
  programs = {
    delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        line-numbers = true;
        minus-style = "syntax #330000";
        navigate = true;
        plus-style = "syntax #003300";
        side-by-side = true;
        syntax-theme = "zenburn";
      };
    };
    gh = {
      enable = true;
      extensions = builtins.concatLists [
        [
          gh-q
        ]
        (with pkgs; [
          gh-actions-lock
          gh-markdown-preview
        ])
      ];
    };
    git = {
      enable = true;
      lfs.enable = true;
      settings = {
        core = {
          autocrlf = "input";
          editor = "nvim";
        };
        extensions.objectFormat = "sha256";
        init.defaultBranch = "main";
        merge.ff = "only";
        pager.reflog = "${config.programs.delta.finalPackage}/bin/delta";
        pull = {
          ff = "only";
          rebase = true;
        };
        push.gpgSign = "if-asked";
        user = {
          email = userEmail;
          name = userName;
        };
      };
      signing = {
        format = "openpgp";
        key = "8C6CE9CF9A90364925410F6DA9CE3FD9B84E680A";
        signByDefault = true;
      };
    };
    mercurial = {
      inherit userEmail userName;
      enable = true;
    };
  };
}
