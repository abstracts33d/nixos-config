{ hostSpec, pkgs }:

with pkgs;
let
  hS = hostSpec;
  commonPackages = import ../../../common/config/nix/packages.nix { inherit hostSpec pkgs; };
  hostPackages = import "../../../../hosts/${hS.hostName}/packages.nix" { inherit hostSpec pkgs; };
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
