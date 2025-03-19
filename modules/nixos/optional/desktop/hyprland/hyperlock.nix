{ config, lib, ... }:

let
  hS = config.hostSpec;
in
{
  config = lib.mkIf (config.hyprland.enable) {
    home-manager.users.${hS.username} = {
      programs.hyprlock = {
        enable = true;
      };
    };
  };
}
