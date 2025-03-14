{
  config,
  pkgs,
  lib,
  ...
}:

let
  hostSpec = config.hostSpec;
  user = config.hostSpec.username;
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
        inherit hostSpec;

        # Nicely reload system units when changing configs
        systemd.user.startServices = "sd-switch";

        home = {
          enableNixpkgsReleaseCheck = false;
          packages =
            pkgs.callPackage (lib.custom.relativeToRoot "modules/darwin/config/nix/packages.nix")
              { };
          stateVersion = "23.11";
        };
        imports = (
          map lib.custom.relativeToRoot [
            "home/common"
            "home/darwin"
          ]
        );
      };
  };
}
