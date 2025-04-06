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
  imports = [
    ../../modules/common/core/host-spec.nix
    ./host-spec.nix
  ];
  disko.devices = diskConfig;
}
