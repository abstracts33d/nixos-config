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
    inputs.impermanence.nixosModules.home-manager.impermanence # TODO move this to home when refatoring to use standalone home-manager
  ];

  config = lib.mkIf (hS.isImpermanent) {
    environment.persistence."/persist" = {
      hideMounts = true;
      directories = [
        "/var/log"
        "/var/lib/nixos"
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
          ".zsh_history"
        ];
      };
    };

    boot.initrd.postResumeCommands = lib.mkAfter ''
      mkdir /btrfs_tmp
      mount /dev/disk/by-label/root /btrfs_tmp
      if [[ -e /btrfs_tmp/@root ]]; then
          mkdir -p /btrfs_tmp/old_roots
          timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/@root)" "+%Y-%m-%-d_%H:%M:%S")
          mv /btrfs_tmp/@root "/btrfs_tmp/old_roots/$timestamp"
      fi

      delete_subvolume_recursively() {
          IFS=$'\n'
          for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
              delete_subvolume_recursively "/btrfs_tmp/$i"
          done
          btrfs subvolume delete "$1"
      }

      for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
          delete_subvolume_recursively "$i"
      done

      btrfs subvolume create /btrfs_tmp/@root
      umount /btrfs_tmp
    '';

    fileSystems."/persist".neededForBoot = true;
  };
}
