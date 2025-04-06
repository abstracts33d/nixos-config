{lib, ...}: let
  diskConfig =
    import ../common/disks/btrfs-impermanence-disk.nix
    {
      inherit lib;
      _module.args = {
        disk = "/dev/sda";
        withSwap = true;
      };
    };
in {
  disko.devices = diskConfig;
}
