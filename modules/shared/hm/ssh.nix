{ config, ... }:
let
  home = config.hostSpec.home;
in
{
  programs.ssh = {
    enable = true;
    includes = [
      "${home}/.ssh/config_external"
    ];
    addKeysToAgent = "yes";
    matchBlocks = {
      "github.com" = {
        identitiesOnly = true;
        identityFile = [
          "${home}/.ssh/id_github"
        ];
      };
    };
  };
}
