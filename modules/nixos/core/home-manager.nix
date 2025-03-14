{
  config,
  pkgs,
  lib,
  ...
}:

let
  hostSpec = config.hostSpec;
  user = config.hostSpec.username;
  home = config.hostSpec.home;
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
          stateVersion = "21.05";
        };
        imports = (
          map lib.custom.relativeToRoot [
            "home/common"
            "home/nixos"
          ]
        );
      };
  };
}
