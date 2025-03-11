{ inputs, config, pkgs, lib, ... }:

{
  config = lib.mkIf (config.hyprland.enable) {

    environment.systemPackages = with pkgs; [
      gnome-keyring
      catppuccin-sddm
    ];

    services = {
      gnome = {
        gnome-keyring.enable = true;
      };
    };

    security.pam.services = {
      sddm.enableGnomeKeyring.enable = true;
    };



    #  home.packages = with pkgs; [
    #    qt5.qtwayland
    #    qt6.qtwayland
    #  ];

    services = {
      displayManager = {
        sddm = {
          enable = true;
          wayland = {
            enable = true;
          };
          theme = "catppuccin-mocha";
        };
      };
    };
  };
}



