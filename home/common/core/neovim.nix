{
  config,
  lib,
  ...
}: let
  hS = config.hostSpec;
in {
  programs.neovim = {
    enable = true;
  };
  home.file."${hS.home}/.config/nvim/" = {
    source = ../config/nvim;
    recursive = true;
  };
}
