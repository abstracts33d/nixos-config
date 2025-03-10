{
  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-24.05;

  outputs = { self, nixpkgs }: {
    nixosConfigurations.live = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        (nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
        ./additional-config.nix
      ];
    };
  };
}
#nix build .#nixosConfigurations.live.config.system.build.isoImage
