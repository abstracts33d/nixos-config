{
  config,
  lib,
  ...
}: let
  hS = config.hostSpec;
in {
  config = lib.mkIf (hS.useAerospace) {
    services.aerospace = {
      enable = true;
    };
  };
}
