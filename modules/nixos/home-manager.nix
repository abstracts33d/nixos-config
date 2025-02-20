{ config, pkgs, ... }:

let
  user = "s33d";
  shared-files = import ../shared/files.nix { inherit user config pkgs; };
in
{
  imports = [
    ./hm/gtk.nix
#    ./hm/services.nix
  ];

  home = {
    enableNixpkgsReleaseCheck = false;
    username = "${user}";
    homeDirectory = "/home/${user}";
    packages = pkgs.callPackage ./packages.nix {};
    file = shared-files // import ./files.nix { inherit user config pkgs; };
    stateVersion = "21.05";
  };

  # programs.kitty.enable = true; # required for the default Hyprland config
  # wayland.windowManager.hyprland.enable = true; # enable Hyprland
}
