{lib, ...}: let
  diskConfig =
    import ../common/disks/btrfs-impermanence-disk.nix
    {
      inherit lib;
      _module.args = {
        withSwap = false;
      };
    };
in {
  disko.devices = diskConfig;
}
