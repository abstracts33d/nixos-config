{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: let
  hS = config.hostSpec;
in {
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  config = lib.mkIf (hS.isImpermanent) {
    environment.persistence."/nix/persist" = {
      hideMounts = true;
      directories = [
        "/var/log"
        "/var/lib/systemd/coredump"
        "/etc/NetworkManager/system-connections"
      ];
      files = [
        # machine-id is used by systemd for the journal, if you don't persist this
        # file you won't be able to easily use journalctl to look at journals for
        # previous boots.
        "/etc/machine-id"
      ];
      users.${hS.userName} = {
        directories = [
          ".local/share/zoxide"
          "Downloads"
        ];
        files = [
          ".bash_history"
          ".zsh_history"
        ];
      };
    };
  };
}
