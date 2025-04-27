{
  config,
  lib,
  ...
}: let
  hS = config.hostSpec;
in {
  config = lib.mkIf (hS.isDev) {
    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      nix-direnv.enable = true; # better than native direnv nix functionality - https://github.com/nix-community/nix-direnv
    };
  };
}
