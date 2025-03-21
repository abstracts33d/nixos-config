{ lib, ... }:
{
  imports = lib.flatten [
    ./host-spec.nix
    (map lib.custom.relativeToRoot [
      "hosts/darwin"
    ])
  ];
  nixpkgs.hostPlatform = "aarch64-darwin";
}
