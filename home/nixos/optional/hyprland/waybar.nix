{ config, lib, ... }:

let
  hS = config.hostSpec;
in
{
  config = lib.mkIf (hS.useHyperland) {
    programs.waybar = {
      enable = true;
      systemd.enable = true;
    };
  };
}
