{ config, pkgs, lib, home-manager, ...}:
 let
  user = config.hostSpec.username;
in
{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  stylix = {
    enable = true;
    # autoEnable = false;

    # If stylix.base16Scheme is undeclared, Stylix generates a color scheme based on the wallpaper
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";

    image = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/orangci/walls-catppuccin-mocha/refs/heads/master/cool.jpg";
      sha256 = "+gmixlxI+gTrWKq5Gnb7yaj/V0JWIO6dlk6uESeJ3ho=";
    };

    polarity = "dark";

    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      monospace = {
        package = pkgs.nerd-fonts.meslo-lg;
        name = "MesloLG NF";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
  home-manager.users.${user} = {
    programs.firefox.profiles = {
      my-profile.extensions.force = true;
    };

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
