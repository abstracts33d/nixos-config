{ lib, ... }:
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

    useGnome = false;
    useHyperland = true;
    useGgm = true;
    useGreetd = false;
  };

  # Qemu and Spice addons
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
}
