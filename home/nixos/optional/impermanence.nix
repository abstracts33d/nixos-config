{
  config,
  inputs,
  lib,
  ...
}: let
  hS = config.hostSpec;
in {
  home = lib.mkIf (hS.isImpermanent) {
    persistence = {
      "/persist/${hS.home}" = {
        defaultDirectoryMethod = "symlink";
        directories = [
          "Documents"
          "Downloads"
          "Pictures"
          "Videos"
        ];
        files = [
          ".zsh_history"
        ];
        allowOther = true;
      };
    };
  };
}
