{ inputs, config, pkgs, lib, ... }:

let
  user = config.hostSpec.username;
in
{
  config = lib.mkIf (config.hyprland.enable) {

    environment.systemPackages = with pkgs; [
      gnome-keyring
      catppuccin-cursors.mochaFlamingo
      (catppuccin-sddm.override {
          flavor = "mocha";
#          font  = "Noto Sans";
#          fontSize = "9";
#          background = "${./wallpaper.png}";
#          loginBackground = true;
        })
    ];

    services = {
      gnome = {
        gnome-keyring.enable = true;
      };
    };

    security.pam.services = {
      sddm.enableGnomeKeyring.enable = true;
    };

    home-manager.users.${user} = {
      packages = with pkgs; [
            qt5.qtwayland
            qt6.qtwayland
          ];
    };

    services = {
      displayManager = {
        sddm = {
          # use Qt6 version for catppucin theme
          package = pkgs.kdePackages.sddm;

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



