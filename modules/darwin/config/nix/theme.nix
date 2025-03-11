{ pkgs, ... }:
{
  stylix = {
    enable = true;

    # prevent error on release check
    enableReleaseChecks = false;

    # If stylix.base16Scheme is undeclared, Stylix generates a color scheme based on the wallpaper
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
  };
}
