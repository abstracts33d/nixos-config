{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = lib.flatten [
    inputs.home-manager.darwinModules.home-manager
    inputs.nix-homebrew.darwinModules.nix-homebrew
    inputs.agenix.darwinModules.default
    {
      environment.systemPackages = [ inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default ];
    }
    ./common
    (map lib.custom.relativeToRoot [
      "modules/darwin/core"
      "modules/darwin/optional"
      "modules/shared"
    ])
  ];

  # Load configuration that is shared across systems
  environment.systemPackages =
    import (lib.custom.relativeToRoot "modules/shared/config/nix/packages.nix")
      {
        inherit pkgs;
      };

  hostSpec = {
    isDarwin = true;
  };
}
