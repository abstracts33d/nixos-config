{lib, ...}: let
  diskConfig =
    import ../common/config/disks/btrfs-impermanence-disk.nix
    {
      inherit lib;
    };
in {
  disko.devices = diskConfig;
}
