{ config, lib, ... }:

{
#  config = lib.mkIf (config.hyprland.enable) {
    programs.tofi = {
      enable = true;
    };
#  };
}
