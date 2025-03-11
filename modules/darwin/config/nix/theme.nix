{ pkgs, config }:
{
  # If stylix.base16Scheme is undeclared, Stylix generates a color scheme based on the wallpaper
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";

  stylix.enable = true;
}
