{ pkgs }:

with pkgs;
[
  # General packages for development and system management
  act
  aspell
  aspellDicts.fr
  aspellDicts.en
  bash-completion
  bat
  btop
  coreutils
  difftastic
  du-dust
  gcc
  killall
  fastfetch
  openssh
  pandoc
  sqlite
  zip
  uv

  # Network
  nmap
  wakeonlan
  wget

  # Encryption and security tools
  age
  bitwarden-cli
  gnupg
  libfido2

  # Cloud-related tools and SDKs
  docker
  docker-compose

  # Media-related packages
  nerd-fonts.meslo-lg
  imagemagick
  dejavu_fonts
  ffmpeg
  fd
  font-awesome
  hack-font
  meslo-lgs-nf
  noto-fonts
  noto-fonts-emoji
  spotifyd

  # Node.js development tools
  nodePackages.live-server
  nodePackages.nodemon
  nodePackages.prettier
  nodePackages.npm
  nodejs
  yarn

  # Source code management, Git, GitHub tools
  gh

  # Text and terminal utilities
  ack
  bat
  colordiff
  coreutils
  duf
  eza
  fd
  fzf
  htop
  hunspell
  iftop
  jetbrains-mono
  jq
  procs
  ripgrep
  sesh
  shellcheck
  starship
  thefuck
  tldr
  tmux
  tree
  unrar
  unzip
  yazi
  zellij
  zoxide

  # Python packages
  black
  python3
  virtualenv

  # To sort
  chezmoi
  fish
  git
  mise
  redis
  neovim
]
