{ lib, ... }:
{
  imports = lib.flatten [
    ./disk-config.nix
    ./host-spec.nix
    (map lib.custom.relativeToRoot [
      "hosts/nixos"
    ])
  ];

  nixpkgs.hostPlatform = "aarch64-linux";

  # Qemu and Spice addons
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
}
