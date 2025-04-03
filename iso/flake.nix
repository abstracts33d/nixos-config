{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    linuxSystems = [
      "x86_64-linux"
      "aarch64-linux"
    ];
    forAllSystems = f: nixpkgs.lib.genAttrs linuxSystems f;
  in {
    nixosConfigurations = nixpkgs.lib.genAttrs linuxSystems (
      system:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            (nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
            ./additional-config.nix
          ];
        }
    );
  };
}
#nix build .#nixosConfigurations.x86_64-linux.config.system.build.isoImage
#nix build .#nixosConfigurations.aarch64-linux.config.system.build.isoImage

