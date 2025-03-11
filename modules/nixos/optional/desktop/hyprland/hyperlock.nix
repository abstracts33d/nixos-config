{ config, lib, ... }:

let
  user = config.hostSpec.user;
in
{
  config = lib.mkIf (config.hyprland.enable) {
    home-manager.users.${user} = {
      programs.hyprlock = {
        enable = true;
        settings = {
          general = {
            disable_loading_bar = true;
            grace = 5; # grace period in seconds that the lock will unlock on mouse movement.
            hide_cursor = true;
          };

          background = lib.mkDefault [
            {
              monitor = "";
              path = "screenshot";
              blur_passes = 4;
              blur_size = 5;
            }
          ];

          input-field = lib.mkDefault [
            {
              monitor = "";
              size = "300, 60";
              outline_thickness = 4;
              dots_size = 0.2;
              dots_spacing = 0.2;
              dots_center = true;
              fade_on_empty = false;
              hide_input = false;
              position = "0, -47";
              halign = "center";
              valign = "center";
            }
          ];
        };
      };
    };
  };
}
