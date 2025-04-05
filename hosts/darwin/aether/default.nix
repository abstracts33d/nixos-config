{lib, ...}: {
  imports = lib.flatten [
    ./host-spec.nix
    ./dock.nix
    (map lib.custom.relativeToRoot [
      "hosts/darwin/base.nix"
    ])
  ];
  nixpkgs.hostPlatform = "aarch64-darwin";
}
