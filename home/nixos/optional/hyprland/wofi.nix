{ config, lib, ... }:

{
  config = lib.mkIf (config.hyprland.enable) {
    programs.wofi = {
      enable = true;
    };
  };
}
