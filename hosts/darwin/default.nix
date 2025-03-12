{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:

let
  user = config.hostSpec.username;
in
{
  imports = lib.flatten [
    inputs.home-manager.darwinModules.home-manager
    inputs.nix-homebrew.darwinModules.nix-homebrew
    inputs.agenix.darwinModules.default
    ./common
    (map lib.custom.relativeToRoot [
      "modules/darwin/core"
      "modules/darwin/optional"
      "modules/shared"
    ])
  ];

  # Load configuration that is shared across systems
  environment.systemPackages = import (lib.custom.relativeToRoot "modules/shared/config/nix/packages.nix") {
    inherit pkgs;
  };

  hostSpec = {
    isDarwin = true;
  };

  # Modules options
  theme = {
    enable = true;
    nix-config = {
      enable = true;
      # prevent error on release check
      enableReleaseChecks = false;

      # If stylix.base16Scheme is undeclared, Stylix generates a color scheme based on the wallpaper
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
    };
  };
}
