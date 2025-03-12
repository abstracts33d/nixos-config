{ inputs, config, pkgs, lib, ... }:

let
  user = config.hostSpec.username;
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
in
{
  config = lib.mkIf (config.hyprland.enable) {
    services.xserver.displayManager.gdm.enable = true;
  };
}
