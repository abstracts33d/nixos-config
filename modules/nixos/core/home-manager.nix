{
  config,
  pkgs,
  home-manager,
  lib,
  ...
}:

let
  hostSpec = config.hostSpec;
  user = config.hostSpec.username;
  home = config.hostSpec.home;
  shared-files = import (lib.custom.relativeToRoot "modules/shared/config/nix/files.nix") {
    inherit user config pkgs lib;
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
        inherit hostSpec;

        # Nicely reload system units when changing configs
        systemd.user.startServices = "sd-switch";

        home = {
          enableNixpkgsReleaseCheck = false;
          username = "${user}";
          homeDirectory = "${home}";
          packages = pkgs.callPackage (lib.custom.relativeToRoot "modules/nixos/config/nix/packages.nix") { };
          file = shared-files // import (lib.custom.relativeToRoot "modules/nixos/config/nix/files.nix") { inherit user config pkgs; };
          stateVersion = "21.05";
        };
        imports = [ (lib.custom.relativeToRoot "modules/shared/home-manager") ];
      };
  };
}
