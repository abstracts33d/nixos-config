{ config, lib, ... }:

{
#  config = lib.mkIf (config.hyprland.enable) {
    programs.hyprlock = {
      enable = true;
    };
#  };
}
