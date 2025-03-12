{ nixpkgs, lib, ... }:
{
  imports = lib.flatten [
    ./disk-config.nix
    (map lib.custom.relativeToRoot [
      "hosts/nixos"
    ])
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

  # Modules options
  gnome.enable = true;
  # hyprland.enable = true;
  theme.enable = true;
}
