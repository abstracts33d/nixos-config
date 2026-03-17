{
  config,
  lib,
  ...
}: let
  hS = config.hostSpec;
in {
  config = lib.mkIf (hS.isDev) {
    programs.mise = {
      enable = true;
      enableBashIntegration = false;
      enableZshIntegration = true;
      enableFishIntegration = false;
    };
  };
}
