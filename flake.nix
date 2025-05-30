{
  description = "General Purpose Nix Config for macOS + NixOS";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence = {
      url = "github:nix-community/impermanence";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
      inputs.darwin.follows = "darwin";
    };
    secrets = {
      url = "git+ssh://git@github.com/abstracts33d/nix-secrets.git";
      flake = false;
    };
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nix-darwin.follows = "darwin";
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    sddm-sugar-candy-nix = {
      url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    self,
    darwin,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;
    inherit (nixpkgs) lib;

    linuxSystems = [
      "x86_64-linux"
      "aarch64-linux"
    ];
    darwinSystems = [
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    forAllSystems = f: nixpkgs.lib.genAttrs (linuxSystems ++ darwinSystems) f;
    devShell = system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      default = with pkgs;
        mkShell {
          nativeBuildInputs = with pkgs; [
            bashInteractive
            git
            age
          ];
          shellHook = with pkgs; ''
            export EDITOR=vim
          '';
        };
    };
    mkApp = scriptName: system: {
      type = "app";
      program = "${
        (nixpkgs.legacyPackages.${system}.writeScriptBin scriptName ''
          #!/usr/bin/env bash
          PATH=${nixpkgs.legacyPackages.${system}.git}/bin:$PATH
          echo "Running ${scriptName} for ${system}"
          exec ${self}/apps/${system}/${scriptName} $@
        '')
      }/bin/${scriptName}";
    };
    mkLinuxApps = system: {
      "build-switch" = mkApp "build-switch" system;
      "install" = mkApp "install" system;
    };
    mkDarwinApps = system: {
      "build" = mkApp "build" system;
      "build-switch" = mkApp "build-switch" system;
      "rollback" = mkApp "rollback" system;
    };

    mkHost = host: isDarwin: {
      ${host} = let
        func =
          if isDarwin
          then darwin.lib.darwinSystem
          else lib.nixosSystem;
        systemFunc = func;
      in
        systemFunc {
          specialArgs = {
            inherit
              inputs
              outputs
              isDarwin
              ;

            # ========== Extend lib with lib.custom ==========
            # NOTE: This approach allows lib.custom to propagate into hm
            # see: https://github.com/nix-community/home-manager/pull/3454
            lib = nixpkgs.lib.extend (_self: _super: {custom = import ./lib {inherit (nixpkgs) lib;};});
          };
          modules = [
            ./hosts/${
              if isDarwin
              then "darwin"
              else "nixos"
            }/${host}
          ];
        };
    };
    # Invoke mkHost for each host config that is declared for either nixos or darwin
    mkHostConfigs = hosts: isDarwin: lib.foldl (acc: set: acc // set) {} (lib.map (host: mkHost host isDarwin) hosts);
    # Return the hosts declared in the given directory
    readHosts = folder: lib.attrNames (builtins.readDir ./hosts/${folder});
  in {
    devShells = forAllSystems devShell;
    apps =
      nixpkgs.lib.genAttrs linuxSystems mkLinuxApps
      // nixpkgs.lib.genAttrs darwinSystems mkDarwinApps;

    nixosConfigurations = mkHostConfigs (readHosts "nixos") false;
    darwinConfigurations = mkHostConfigs (readHosts "darwin") true;

    # Nix formatter available through 'nix fmt' https://nix-community.github.io/nixpkgs-fmt
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
  };
}
