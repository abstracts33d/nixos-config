{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  hS = config.hostSpec;
  hostSpec = config.hostSpec;
in {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "_nbkp";
    users.root = {
      hashedPasswordFile = "${inputs.secrets}/hashed-password-file";
      stateVersion = "21.05";
    };
    users.${hS.userName} = {...}: {
      inherit hostSpec;

      # Nicely reload system units when changing configs
      systemd.user.startServices = "sd-switch";

      home = {
        enableNixpkgsReleaseCheck = false;
        username = "${hS.userName}";
        homeDirectory = "${hS.home}";
        packages = pkgs.callPackage (lib.custom.relativeToRoot "modules/nixos/config/nix/packages.nix") {
          hostSpec = hostSpec;
        };
        stateVersion = "21.05";
      };
      imports = (
        map lib.custom.relativeToRoot [
          "modules/common/core/host-spec.nix"
          "home/common"
          "home/nixos"
        ]
      );

      hashedPasswordFile = "${inputs.secrets}/hashed-password-file";
    };
  };
}
