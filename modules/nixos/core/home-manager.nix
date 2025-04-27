{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: let
  hS = config.hostSpec;
  hostSpec = config.hostSpec;
in {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "_nbkp";
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
      imports = lib.flatten [
        inputs.impermanence.nixosModules.home-manager.impermanence # TODO
        (map lib.custom.relativeToRoot [
          "modules/common/core/host-spec.nix"
          "home/common"
          "home/nixos"
        ])
      ];
    };
  };
}
