_: let
diskConfig = import "../common/disks/btrfs-impermanence-disk.nix"
                        {
                          _module.args = {
                            withSwap = false;
                          };
                        };
in {
  disko.devices = diskConfig;
}
