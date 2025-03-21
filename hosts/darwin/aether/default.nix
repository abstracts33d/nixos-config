{ lib, ... }:
{
  imports = lib.flatten [
    ./host-spec
    (map lib.custom.relativeToRoot [
      "hosts/darwin"
    ])
  ];
  nixpkgs.hostPlatform = "aarch64-darwin";
}
