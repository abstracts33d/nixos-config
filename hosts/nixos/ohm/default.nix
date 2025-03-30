{ lib, ... }:
{
  imports = lib.flatten [
    ./hardware-configuration.nix
    ./disk-config.nix
    ./host-spec.nix
    (map lib.custom.relativeToRoot [
      "hosts/nixos"
    ])
  ];

  services.xserver.xkb.layout = "fr,us";
  console.keyMap = "fr";

  nixpkgs.hostPlatform = "x86_64-linux";
}
