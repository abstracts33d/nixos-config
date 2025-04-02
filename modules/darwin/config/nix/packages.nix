{ hostSpec, pkgs }:

with pkgs;
let
  hS = hostSpec;
  commonPackages = import ../../../common/config/nix/packages.nix { inherit hostSpec pkgs; };
  hostPackages = import "../../../../hosts/${hS.hostname}/packages.nix" { inherit hostSpec pkgs; };
in
commonPackages
++ hostPackages
++ [
  dockutil
  mas
]
