{ nixpkgs, ... }:
{
  imports = [
    ../../nixos
    ./disk-config.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  hostSpec = {
    hostName = "krach";
    username = "s33d";
    githubUser = "abstracts33d";
    githubEmail = "abstract.s33d@gmail.com";
    networking = {
      interface = "enp0s3";
    };
  };
}
