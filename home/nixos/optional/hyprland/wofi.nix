{
  config,
  lib,
  ...
}: let
  hS = config.hostSpec;
in {
  config = lib.mkIf (hS.useHyprland) {
    programs.wofi = {
      enable = true;
    };
  };
}
