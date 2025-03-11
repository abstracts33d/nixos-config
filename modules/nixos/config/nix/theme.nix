{ pkgs, }:
{
  # If stylix.base16Scheme is undeclared, Stylix generates a color scheme based on the wallpaper
   stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";

  stylix.enable = true;

  stylix.image = pkgs.fetchurl {
    url = "https://github.com/orangci/walls-catppuccin-mocha/blob/master/space.jpg";
    sha256 = "gByskUnDXbiA43YXNBx5zenAj2iiCBMKWyC1gmCeONY=";
  };

  stylix.polarity = "dark";

  stylix.fonts = {
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

  # stylix.autoEnable = false;
}
