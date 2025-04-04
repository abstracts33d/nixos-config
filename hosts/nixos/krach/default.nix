{lib, ...}: {
  imports = lib.flatten [
    ./disk-config.nix
    ./host-spec.nix
    (map lib.custom.relativeToRoot [
      "hosts/nixos/base.nix"
    ])
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
}
