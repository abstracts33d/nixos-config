{
  pkgs,
  config,
  lib,
  ...
}:
{
  options = {
    aerospace = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
    };
  };

  config = lib.mkIf (config.aerospace.enable) {
    services.aerospace = {
      enable = true;
    };
  };
}
