{ lib, ... }:
{
  imports = lib.flatten [
    ./disk-config.nix
    (map lib.custom.relativeToRoot [
      "hosts/nixos"
    ])
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  hostSpec = {
    hostName = "ohm";
    username = "sabrina";
    githubUser = "abstracts33d";
    githubEmail = "abstract.s33d@gmail.com";
    networking = {
      interface = "enp2s0";
    };

    useGnome = true;
  };
}
