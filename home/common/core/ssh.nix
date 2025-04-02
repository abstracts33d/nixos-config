{config, ...}: let
  hS = config.hostSpec;
in {
  programs.ssh = {
    enable = true;
    includes = [
      "${hS.home}/.ssh/config_external"
    ];
    addKeysToAgent = "yes";
    matchBlocks = {
      "github.com" = {
        identitiesOnly = true;
        identityFile = [
          "${hS.home}/.ssh/id_ed25519"
        ];
      };
    };
  };
}
