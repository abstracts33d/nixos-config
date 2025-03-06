{ nixpkgs, ... }:
{
  imports = [
    ../../nixos
    ./disk-config.nix
    ../../../../features/desktop/gnome
  ];

  nixpkgs.hostPlatform = "aarch64-linux";

  hostSpec = {
    hostName = "utm";
    username = "s33d";
    githubUser = "abstracts33d";
    githubEmail = "abstract.s33d@gmail.com";
    networking = {
      interface = "enp0s1";
    };
  };
}
