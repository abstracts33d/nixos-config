{ pkgs }:

with pkgs;
let
  commonPackages = import ../../../common/config/nix/packages.nix { inherit pkgs; };
in
commonPackages
++ [
  # Editors
  vscode
  # jetbrains.ruby-mine

  # Security and authentication
  bitwarden-cli

  # App and package management
  appimage-run
  gnumake
  cmake
  home-manager

  # Media and design tools
  vlc
  fontconfig
  font-manager

  # Productivity tools
  galculator

  # Audio tools
  pavucontrol # Pulse audio controls

  # Testing and development tools
  direnv
  postgresql

  # Screenshot and recording tools
  flameshot

  # Text and terminal utilities
  feh # Manage wallpapers
  tree
  unixtools.ifconfig
  unixtools.netstat

  # File and system utilities
  sqlite
  xdg-utils

  # Other utilities
  xdotool

  # Browsers
  google-chrome
  firefox

  # PDF viewer
  zathura

  # Music and entertainment
  spotifyd
]
