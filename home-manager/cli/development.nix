{pkgs, ...}: let
  stack-wrapped = pkgs.symlinkJoin {
    buildInputs = [
      pkgs.makeWrapper
    ];
    name = "stack";
    paths = [
      pkgs.stack
    ];
    postBuild = ''
      wrapProgram $out/bin/stack --add-flags "--no-nix --system-ghc --no-install-ghc"
    '';
  };
in {
  home.packages = (with pkgs; [
    buf
    cue
    deno
    gcc
    ghc
    nodejs-slim
    ocaml
    protobuf
    python312
    rust-bin.nightly.latest.default
    stack-wrapped
    supabase-cli
    zig
  ]) ++ (with pkgs.nodePackages; [
    npm
    pnpm
    yarn
  ]) ++ (with pkgs.ocamlPackages; [
    dune_3
  ]);
  programs = {
    bun.enable = true;
    go.enable = true;
  };
}
