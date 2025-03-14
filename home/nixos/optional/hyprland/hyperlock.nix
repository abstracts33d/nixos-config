{ config, lib, ... }:

let
  user = config.hostSpec.username;
in
{
  config = lib.mkIf (config.hyprland.enable) {
    programs.hyprlock = {
      enable = true;
    };
  };
}
