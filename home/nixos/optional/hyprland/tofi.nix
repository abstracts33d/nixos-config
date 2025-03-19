{ config, lib, ... }:

let
  hS = config.hostSpec;
in
{
  config = lib.mkIf (hS.useHyperland) {
    programs.tofi = {
      enable = true;
    };
  };
}
