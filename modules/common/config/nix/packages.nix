{ config, pkgs }:

with pkgs;
let
  hS = config.hostSpec;
in
[
  # General packages for development and system management
  act
  aspell
  aspellDicts.fr
  aspellDicts.en
  bash-completion
  btop
  coreutils
  difftastic
  gcc
  killall
  uv

  # Files
  zip

  # Network
  nmap
  openssh
  rsync
  wakeonlan
  wget

  # Encryption and security tools
  age
  bitwarden-cli
  gnupg

  # Media-related packages
  nerd-fonts.meslo-lg
  imagemagick
  dejavu_fonts
  ffmpeg
  font-awesome
  hack-font
  meslo-lgs-nf
  noto-fonts
  noto-fonts-emoji

  # Source code management, Git, GitHub tools
  gh

  # Shell
  ack
  bat
  colordiff
  duf
  eza
  fastfetch
  fd
  fish
  fzf
  git
  htop
  hunspell
  iftop
  jetbrains-mono
  jq
  neovim
  procs
  ripgrep
  shellcheck
  starship
  thefuck
  tldr
  tmux
  tree
  unrar
  unzip
  yazi
  yq
  zellij
  zoxide

  # Nix stuff
  nix-tree
  nix-melt
  nh
  alejandra
  deadnix

  # to test
  helix
  newsboat
  neomutt
  cmus
  mpd
  pgcli
  iredis
  asciinema
]
++ [
  mise
  redis

  # Node.js development tools
  nodePackages.live-server
  nodePackages.nodemon
  nodePackages.prettier
  nodePackages.npm
  nodejs
  yarn

  # Python packages
  black
  python3
  virtualenv

  # Cloud-related tools and SDKs
  docker
  docker-compose
]
++ [
  spotifyd
]
