{lib, ...}: let
  diskConfig =
    import ../common/config/disks/btrfs-impermanence-disk.nix
    {
      inherit lib;
      disk = "/dev/sda";
    };
in {
  disko.devices = diskConfig;
}
