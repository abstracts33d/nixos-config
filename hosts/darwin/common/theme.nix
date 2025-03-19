{
  inputs,
  config,
  pkgs,
  ...
}:
let
  hS = config.hostSpec;
in
{
  imports = [
    inputs.stylix.darwinModules.stylix
  ];

  stylix = {
    enable = true;
    # prevent error on release check
    enableReleaseChecks = false;

    # If stylix.base16Scheme is undeclared, Stylix generates a color scheme based on the wallpaper
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
  };
  home-manager.users.${hS.username} = { };
}
