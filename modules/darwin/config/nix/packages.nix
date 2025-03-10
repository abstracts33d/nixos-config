{ pkgs }:

with pkgs;
let
  shared-packages = import ../../../shared/config/nix/packages.nix { inherit pkgs; };
in
shared-packages
++ [
  dockutil
  mas
]
