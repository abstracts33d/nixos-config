{
  config,
  pkgs,
  ...
}: let
  hS = config.hostSpec;
in {
  nix = {
    package = pkgs.nix;
    enable = false; # For nix-darwin to work with Determinate install
    settings = {
      trusted-users = [
        "@admin"
        "${hS.username}"
      ];
      substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org"
      ];
      trusted-public-keys = ["cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="];
    };

    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
