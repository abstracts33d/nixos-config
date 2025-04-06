{
  lib,
  disk ? "/dev/vda",
  withSwap ? false,
  swapSize ? 8,
  config,
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
