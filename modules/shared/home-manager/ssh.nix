{ config, ... }:
let
  cfg = config.hostSpec;
in
{
  programs.ssh = {
    enable = true;
    includes = [
      "${cfg.home}/.ssh/config_external"
    ];
    addKeysToAgent = "yes";
    matchBlocks = {
      "github.com" = {
        identitiesOnly = true;
        identityFile = [
          "${cfg.home}/.ssh/id_github_ed25519"
        ];
      };
    };
  };
}
