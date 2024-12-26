(import (
  let
    lock = builtins.fromJSON (builtins.readFile ./flake.lock);
    nodeName = lock.nodes.root.inputs.flake-compat;
  in
  fetchTarball {
    sha256 = lock.nodes.${nodeName}.locked.narHash;
    url =
      lock.nodes.${nodeName}.locked.url
        or "https://github.com/edolstra/flake-compat/archive/${lock.nodes.${nodeName}.locked.rev}.tar.gz";
  }
) { src = ./.; }).defaultNix
# vim: et sts=2 sw=2 ts=2
