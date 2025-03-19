{ config, lib, ... }:

let
  cfg = config.hostSpec;
in
{
  config = lib.mkIf (config.hyprland.enable) {
    home-manager.users.${cgf.username} = {
      programs.wofi = {
        enable = true;
      };
    };
  };
}
