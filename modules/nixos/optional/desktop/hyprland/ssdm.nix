{ inputs, config, pkgs, lib, ... }:

{
  config = lib.mkIf (config.hyprland.enable) {
    services = {
      displayManager = {
        sddm = {
          enable = true;
          package = pkgs.kdePackages.sddm;
          wayland = {
            enable = true;
          };
          settings = {
            Wayland = {
              SessionDir = "${inputs.hyprland.packages.${pkgs.system}.hyprland}/share/wayland-sessions";
            };
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
