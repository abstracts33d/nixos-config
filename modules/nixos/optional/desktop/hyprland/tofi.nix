{ config, lib, ... }:
{
  config = lib.mkIf (config.hyprland.enable) {

  };
}
