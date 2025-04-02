{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: let
  hostSpec = config.hostSpec;
in {
  imports = lib.flatten [
    inputs.home-manager.darwinModules.home-manager
    inputs.nix-homebrew.darwinModules.nix-homebrew
    inputs.agenix.darwinModules.default
    {
      environment.systemPackages = [inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default];
    }
    ./common
    (map lib.custom.relativeToRoot [
      "modules/common"
      "modules/darwin"
    ])
  ];

  # Load configuration that is shared across systems
  environment.systemPackages =
    import (lib.custom.relativeToRoot "modules/common/config/nix/packages.nix")
    {
      inherit hostSpec pkgs;
    };

  hostSpec = {
    isDarwin = true;
  };
}
