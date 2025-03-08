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
    ./common
    (map lib.custom.relativeToRoot [
      "modules/darwin/core"
      "modules/darwin/optional/dock.nix"
      "modules/shared"
    ])
  ];

  # Load configuration that is shared across systems
  environment.systemPackages = import (lib.custom.relativeToRoot "modules/shared/packages.nix") {
    inherit pkgs;
  };
}
