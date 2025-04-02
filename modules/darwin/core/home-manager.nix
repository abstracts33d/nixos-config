{
  config,
  pkgs,
  lib,
  ...
}:

let
  hostSpec = config.hostSpec;
in
{
  # Enable home-manager
  home-manager = {
    useGlobalPkgs = true;
    users.${hostSpec.username} =
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
              { hostSpec = hostSpec; };
          stateVersion = "23.11";
        };
        imports = (
          map lib.custom.relativeToRoot [
            "modules/common/core/host-spec.nix"
            "home/common"
            "home/darwin"
          ]
        );
      };
  };
}
