{lib, ...}: let
  diskConfig =
    import ../common/config/disks/btrfs-impermanence-disk.nix
    {
      inherit lib;
      disk = "/dev/nvme0n1";
    };
in {
  disko.devices = diskConfig;
}
