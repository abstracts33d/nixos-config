{ nixpkgs, lib, ... }:
{
  imports = lib.flatten [
    ./disk-config.nix
    (map lib.custom.relativeToRoot [
      "hosts/nixos"
    ])
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

  # Modules options
  # gnome.enable = true;
  hyprland.enable = true;

  hyprland = {
   enable = true;
   dm.greetd.enable = true;
  };

  # Qemu and Spice addons
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
}
