{ config, pkgs }:

with pkgs;
let
  hS = config.hostSpec;
  commonPackages = import ../../../common/config/nix/packages.nix { inherit config pkgs; };
  hostPackages = import "../../../../hosts/${hS.hostname}/packages.nix" { inherit config pkgs; };
in
commonPackages
++ hostPackages
++ [
  dockutil
  mas
]
