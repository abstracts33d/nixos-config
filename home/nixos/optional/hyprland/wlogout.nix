{
  config,
  lib,
  ...
}:

let
  hS = config.hostSpec;
in
{
  config = lib.mkIf (hS.useHyperland) {
    programs.wlogout = {
      enable = true;
    };
  };
}
