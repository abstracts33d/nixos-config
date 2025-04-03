{
  inputs,
  config,
  pkgs,
  ...
}: let
  hS = config.hostSpec;
in {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  stylix = {
    enable = hS.useTheme;
    # autoEnable = false;

    # If stylix.base16Scheme is undeclared, Stylix generates a color scheme based on the wallpaper
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";

    image = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/orangci/walls-catppuccin-mocha/refs/heads/master/cool.jpg";
      sha256 = "g6cFnOT4GICHD7xGy28lrr2GT4gE4q6mCtWqNCweP38=";
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
  home-manager.users.${hS.username} = {
    programs.firefox.profiles = {
      my-profile.extensions.force = true;
    };

    stylix = {
      targets = {
        halloy.enable = true;
        firefox = {
          colorTheme.enable = true;
          firefoxGnomeTheme.enable = true;
          profileNames = ["my-profile"];
        };

        vscode.profileNames = ["my-profile"];
      };
    };
  };
}
