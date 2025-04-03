{
  config,
  lib,
  ...
}: let
  hS = config.hostSpec;
in {
  config = lib.mkIf (hS.isGraphical) {
    programs.google-chrome = {
      enable = true;
    };
  };
}
