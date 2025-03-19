{
  config,
  pkgs,
  lib,
  ...
}:

let
  user = config.hostSpec.username;
  sharedFiles = import (lib.custom.relativeToRoot "modules/shared/config/nix/files.nix") {
    inherit
      user
      config
      pkgs
      lib
      ;
  };
  additionalFiles = import (lib.custom.relativeToRoot "modules/darwin/config/nix/files.nix") {
    inherit user config pkgs;
  };
in
{
  # Enable home-manager
  home-manager = {
    useGlobalPkgs = true;
    users.${user} =
      {
        pkgs,
        lib,
        ...
      }:
      {
        # Nicely reload system units when changing configs
        systemd.user.startServices = "sd-switch";

        home = {
          enableNixpkgsReleaseCheck = false;
          packages =
            pkgs.callPackage (lib.custom.relativeToRoot "modules/darwin/config/nix/packages.nix")
              { };
          file = lib.mkMerge [
            sharedFiles
            additionalFiles
          ];
          stateVersion = "23.11";
        };
        imports = [ (lib.custom.relativeToRoot "modules/shared/home-manager") ];
      };
  };
}
