{ inputs, config, lib, pkgs, ... }:
let
  theme = import ../config/nix/theme.nix { inherit pkgs; };
in
{
#  imports = [
#    inputs.stylix.nixosModules.stylix
#  ];

  options = {
    theme = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
    };
  };

#  config = lib.mkIf (config.theme.enable) theme;
}
