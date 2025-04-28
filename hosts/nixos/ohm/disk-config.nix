{lib, ...}: let
  diskConfig =
    import ../common/config/disks/btrfs-impermanence-disk.nix
    {
      inherit lib;
      disk = "/dev/sda";
      withSwap = true;
      swapSize = "8";
    };
in {
  disko.devices = diskConfig;
}
