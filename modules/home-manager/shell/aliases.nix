{ config, lib, ... }:
let
  inherit (lib) mkOption optionalAttrs types;
  cfg = config.ms0503.shell.aliases;
  shellType = config.ms0503.shell.type;
in
{
  config = {
    programs."${shellType}".shellAliases = {
      cat = "bat";
      cl-c = "wl-copy";
      cl-p = "wl-paste";
      fzcd = ''cd "$(fzf --walker dir,follow,hidden || echo "$PWD")"'';
      g = "git";
      gA = "git add";
      gAp = "git add -p";
      gD = "git diff";
      gDc = "git diff --cached";
      ga = "git add -A";
      gb = "git branch";
      gc = "git commit";
      gcl = "git clone --recurse-submodules";
      gcm = "git commit -m";
      gco = "git checkout";
      gcoM = "git checkout master";
      gcom = "git checkout main";
      gd = "git diff HEAD";
      gdc = "git diff --cached HEAD";
      gf = "git fetch";
      gfu = "git fetch upstream";
      # gfzcd = ''cd "$(ghq root)/$(ghq list | fzf)"'';
      gfzcd = ''cd "$(DIR=$(ghq list | fzf || echo "$PWD"); [[ $DIR = $PWD ]] && echo "$PWD" || echo "$(ghq root)/$DIR")"'';
      gl = "git log --all --decorate --graph --oneline";
      gm = "git merge";
      gp = "git push";
      gpf = "git push -f";
      gpl = "git pull";
      gpuo = "git push -u origin";
      gpuoM = "git push -u origin master";
      gpuom = "git push -u origin main";
      grb = "git rebase";
      grbi = "git rebase -i";
      grm = "git remote";
      grmao = "git remote add origin";
      grmau = "git remote add upstream";
      grmso = "git remote set-url origin";
      grmsu = "git remote set-url upstream";
      grmv = "git remote -v";
      grs = "git reset";
      grsH = "git reset --hard";
      grsM = "git reset --mixed";
      grsS = "git reset --soft";
      grsh = "git reset --hard HEAD^";
      grsm = "git reset --mixed HEAD^";
      grss = "git reset --soft HEAD^";
      gs = "git status";
      gst = "git stash";
      gsta = "git stash apply";
      gstd = "git stash drop";
      gstl = "git stash list";
      gstp = "git stash pop";
      gt = "git tag";
      gtd = "git tag -d";
      gtm = "git tag -m";
      la = "eza -aa";
      ll = "eza -gl";
      lla = "eza -aagl";
      ls = "eza";
      open = "xdg-open";
      top = "bottom";
      wc = "tokei";
    }
    // optionalAttrs (shellType == "zsh") {
      nix = "noglob nix"; # In zsh, '#' has special meaning
    }
    // cfg;
  };
  options.ms0503.shell.aliases = mkOption {
    description = "Shell aliases.";
    type = types.attrsOf types.str;
  };
}
