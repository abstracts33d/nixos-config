{
  config,
  pkgs,
  lib,
  home-manager,
  ...
}:

let
  hostSpec = config.hostSpec;
  user = config.hostSpec.username;
  sharedFiles = import (lib.custom.relativeToRoot "modules/shared/files.nix") {
    inherit user config pkgs;
  };
  additionalFiles = import (lib.custom.relativeToRoot "modules/darwin/files.nix") {
    inherit user config pkgs;
  };
in
{
  imports = [
    # ./hm/shell.nix
  ];

  # Enable home-manager
  home-manager = {
    useGlobalPkgs = true;
    users.${user} =
      {
        pkgs,
        config,
        lib,
        ...
      }:
      {
        inherit hostSpec;

        home = {
          enableNixpkgsReleaseCheck = false;
          packages = pkgs.callPackage (lib.custom.relativeToRoot "modules/darwin/packages.nix") { };
          file = lib.mkMerge [
            sharedFiles
            additionalFiles
          ];
          stateVersion = "23.11";
        };
        imports = [ (lib.custom.relativeToRoot "modules/shared/home-manager.nix") ];
      };
  };
}
