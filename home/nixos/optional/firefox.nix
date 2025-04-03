{
  config,
  lib,
  ...
}: let
  hS = config.hostSpec;
in {
  config = lib.mkIf (hS.isGraphical) {
    programs.firefox = {
      enable = true;
    };
  };
}
