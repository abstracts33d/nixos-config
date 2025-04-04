{
  config,
  inputs,
  lib,
  ...
}: let
  hS = config.hostSpec;
in {
  persistence = {
    "/persist/${hS.home}" = {
      defaultDirectoryMethod = "symlink";
      directories = [
        "Documents"
        "Downloads"
        "Pictures"
        "Videos"
        ".local/bin"
        ".local/share/nix" # trusted settings and repl history
      ];
      files = [
        ".zsh_history"
      ];
      allowOther = true;
    };
  };
}
