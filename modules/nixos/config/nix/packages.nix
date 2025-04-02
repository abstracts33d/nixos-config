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
  # Testing and development tools
  direnv
  postgresql

  # Text and terminal utilities
  tree
  unixtools.ifconfig
  unixtools.netstat

  # File and system utilities
  xdg-utils

]
++ [
  # Documents
  libreoffice

  # Audio
  vlc
  pavucontrol

  # Desktop
  flameshot # Screenshot and recording tools
  zathura # PDF viewer
]
++ [
  # Dev
  vscode
  # jetbrains.ruby-mine
  # slack
]
