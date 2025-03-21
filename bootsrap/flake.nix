{
  description = "Minimal NixOS configuration for bootstrapping systems";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      inherit (self) outputs;

      minimalSpecialArgs = {
        inherit inputs outputs;
        lib = nixpkgs.lib.extend (self: super: { custom = import ../lib { inherit (nixpkgs) lib; }; });
      };

      newConfig =
        name:
        (nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = minimalSpecialArgs;
          modules = [
            inputs.disko.nixosModules.disko
            ./modules/common/core/host-spec.nix
#            ./hosts/nixos/${name}/disk-config.nix
#            ./hosts/nixos/${name}/host-spec.nix
#            ./hosts/nixos/common/core
#            ./hosts/nixos/${name}/hardware-configuration.nix
#            ./minimal-configuration.nix
          ];
        });
    in
    {
      nixosConfigurations = {
        krach = newConfig "krach";
        utm = newConfig "utm";
        ohm = newConfig "ohm";
      };
    };
}
