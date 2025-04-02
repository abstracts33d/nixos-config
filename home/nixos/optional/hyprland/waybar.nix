{
  config,
  lib,
  ...
}: let
  hS = config.hostSpec;
in {
  config = lib.mkIf (hS.useHyprland) {
    programs.waybar = {
      enable = true;
      systemd.enable = true;
    };
  };
}
