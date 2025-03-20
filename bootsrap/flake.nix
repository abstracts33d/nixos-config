{
  description = "General Purpose Nix Config Bootsraper";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      darwin,
      nixpkgs,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      inherit (nixpkgs) lib;

      linuxSystems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      forAllSystems = f: nixpkgs.lib.genAttrs (linuxSystems) f;

      mkHost = host: {
        ${host} =
          let
            systemFunc = lib.nixosSystem;
          in
          systemFunc {
            specialArgs = {
              inherit
                inputs
                outputs
                ;
            };
          };
      };
      # Invoke mkHost for each host config that is declared for either nixos or darwin
      mkHostConfigs =
        hosts: lib.foldl (acc: set: acc // set) { } (lib.map (host: mkHost host) hosts);
      # Return the hosts declared in the given directory
      readHosts = folder: lib.attrNames (builtins.readDir ./hosts/${folder});
    in
    {
      nixosConfigurations = mkHostConfigs (readHosts "nixos") false;
    };
}
