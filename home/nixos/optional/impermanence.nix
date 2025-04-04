{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: let
  hS = config.hostSpec;
in {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];
}
