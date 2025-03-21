{ lib, ... }:
{
  imports = lib.flatten [
    ./disk-config.nix
    ./host-spec
    (map lib.custom.relativeToRoot [
      "hosts/nixos"
    ])
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
}
