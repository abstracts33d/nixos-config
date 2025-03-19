{ config, lib, ... }:

{
#  config = lib.mkIf (config.hyprland.enable) {
    programs.waybar = {
      enable = true;
      systemd.enable = true;
    };
#  };
}
