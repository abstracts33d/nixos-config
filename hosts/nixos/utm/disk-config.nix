{
  lib,
  disk ? "/dev/vda",
  withSwap ? false,
  swapSize ? 8,
  ...
}: {
  imports = [
    "../common/disks/btrfs-impermanence-disk.nix"
    {
      _module.args = {
        withSwap = false;
      };
    }
  ];
}
