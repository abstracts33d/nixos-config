{
  config,
  pkgs,
  home-manager,
  ...
}:

let
  user = config.hostSpec.username;
  shared-files = import ../shared/files.nix { inherit user config pkgs; };
in
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "_nbkp";
    users.${user} =
      { ... }:
      {
        home = {
          enableNixpkgsReleaseCheck = false;
          username = "${user}";
          homeDirectory = "/home/${user}";
          packages = pkgs.callPackage ./packages.nix { };
          file = shared-files // import ./files.nix { inherit user config pkgs; };
          stateVersion = "21.05";
        };
        imports = [
          ../shared/home-manager.nix
          ./hm/gtk.nix
        ];
      };
  };
}
