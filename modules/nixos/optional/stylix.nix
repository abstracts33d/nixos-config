{ inputs, config, lib, pkgs, home-manager, ... }:
let
  theme = import ../config/nix/theme.nix { inherit inputs pkgs config lib; };
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
}
