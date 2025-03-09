{
  config,
  pkgs,
  home-manager,
  lib,
  ...
}:

let
  user = config.hostSpec.username;
  shared-files = import (lib.custom.relativeToRoot "modules/shared/files.nix") {
    inherit user config pkgs;
  };
in
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "_nbkp";
    users.${user} =
      { ... }:
      {
        home = {
          enableNixpkgsReleaseCheck = false;
          username = "${user}";
          homeDirectory = "/home/${user}";
          packages = pkgs.callPackage (lib.custom.relativeToRoot "modules/nixos/packages.nix") { };
          file = shared-files // import (lib.custom.relativeToRoot "modules/nixos/files.nix") { inherit user config pkgs; };
          stateVersion = "21.05";
        };
        imports = [ (lib.custom.relativeToRoot "modules/shared/home-manager.nix") ];
      };
  };
}
