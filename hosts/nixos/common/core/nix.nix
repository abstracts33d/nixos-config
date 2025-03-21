{ config, pkgs, ... }:
let
  hS = config.hostSpec;
in
{
  nix = {
    nixPath = [ "nixos-config=${hS.home}/.local/share/src/nixos-config:/etc/nixos" ];
    settings = {
      allowed-users = [ "${hS.username}" ];
      trusted-users = [
        "@admin"
        "${hS.username}"
      ];
      substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org"
      ];
      trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
    };

    package = pkgs.nix;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
