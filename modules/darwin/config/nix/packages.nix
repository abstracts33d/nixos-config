{ pkgs }:

with pkgs;
let
  commonPackages = import ../../../common/config/nix/packages.nix { inherit pkgs; };
in
commonPackages
++ [
  dockutil
  mas
]
