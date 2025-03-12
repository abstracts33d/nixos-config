{ config, pkgs, lib, home-manager, ...}:
 let
  user = config.hostSpec.username;
in
{
  options = {
    theme = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
      nix-config = lib.mkOption {
        type =  lib.types.attrsOf lib.types.anything;
        default = {};
      };
      hm-config = lib.mkOption {
        type =  lib.types.attrsOf lib.types.anything;
        default = {};
      };
    };
  };

  config = lib.mkIf (config.theme.enable) {
    stylix = config.theme.nix-config;
    home-manager.users.${user} = config.theme.hm-config;
  };
}
