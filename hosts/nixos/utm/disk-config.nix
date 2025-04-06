_: {
  imports = [
    "../common/disks/btrfs-impermanence-disk.nix"
    {
      _module.args = {
        withSwap = false;
      };
    }
  ];
}
