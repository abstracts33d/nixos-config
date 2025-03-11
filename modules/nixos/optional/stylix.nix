{ inputs, config, lib, pkgs, home-manager, ... }:
let
  user = config.hostSpec.username;
  theme = import ../config/nix/theme.nix { inherit pkgs; };
in
{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  options = {
    theme = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
    };
  };

  config = lib.mkIf (config.theme.enable) theme;

  config = lib.mkIf (config.theme.enable) {
    home-manager.users.${user} = {
      stylix = {
        targets = {
          firefox = {
            colorTheme.enable = true;
            firefoxGnomeTheme.enable = true;
            profileNames = [ "my-profile" ];
          };

          vscode.profileNames = [ "my-profile" ];
        };
      };
    };
  };
}
