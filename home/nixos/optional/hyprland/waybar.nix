{ config, lib, ... }:

let
  user = config.hostSpec.username;
in
{
  config = lib.mkIf (config.hyprland.enable) {
    programs.waybar = {
      enable = true;
      systemd.enable = true;
    };
  };
}
