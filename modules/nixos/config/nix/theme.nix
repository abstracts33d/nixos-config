{ pkgs, inputs, ... }:
{
  # If stylix.base16Scheme is undeclared, Stylix generates a color scheme based on the wallpaper
  # inputs.stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";

  inputs.stylix.image = pkgs.fetchurl {
    url = "https://www.pixelstalk.net/wp-content/uploads/2016/05/Epic-Anime-Awesome-Wallpapers.jpg";
    sha256 = "enQo3wqhgf0FEPHj2coOCvo7DuZv+x5rL/WIo4qPI50=";
  };

  inputs.stylix.polarity = "dark";

  inputs.stylix.fonts = {
    serif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Serif";
    };

    sansSerif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
    };

    monospace = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans Mono";
    };

    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
  };

  inputs.stylix.targets.vscode.enable = false;
}
