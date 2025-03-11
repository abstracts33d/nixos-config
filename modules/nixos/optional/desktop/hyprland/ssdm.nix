{ inputs, config, pkgs, lib, ... }:

{
  config = lib.mkIf (config.hyprland.enable) {
    services = {
      displayManager = {
        sddm = {
          enable = true;
          wayland = {
            enable = true;
          };
#          catppuccin = {
#            enable = true;
#            assertQt6Sddm = true;
#            flavor = "macchiato";
#            font = "0xProto Nerd Font";
#            fontSize = "12";
#            loginBackground = true;
#          };
        };
      };
    };
  };
}

#  environment.systemPackages = [
#    pkgs.gnome-keyring
#  ];
#
#  services = {
#    gnome = {
#      gnome-keyring.enable = true;
#    };
#  };
#
#  security.pam.services = {
#    sddm.enableGnomeKeyring.enable = true;
#  };



#  home.packages = with pkgs; [
#    qt5.qtwayland
#    qt6.qtwayland
#  ];
