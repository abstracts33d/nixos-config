{
  config,
  pkgs,
  lib,
  ...
}:

{
  options = {
    hyprland = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
    };
  };

  config = lib.mkIf (config.hyprland.enable) {
    xdg.enable = true;

    wayland.windowManager.hyprland = {
      enable = true;
      # TODO do this
      settings = {
        "$mod" = "SUPER";

        "$terminal" = "kitty";
        "$browser" = "firefox";
        "$launcher" = "tofi-drun";
        "$launcher_alt" = "tofi-run";
        "$launcher2" = "wofi --show drun -n";
        "$launcher2_alt" = "wofi --show run -n";
        "$editor" = "code";

        bind = [
          # General
          "$mod, return, exec, $terminal"

          "$mod, a, exec, $launcher"
          "$mod, s, exec, $launcher_alt"
          "$mod, d, exec, $launcher2"
          "$mod, f, exec, $launcher2_alt"

          "$mod SHIFT, q, killactive"
          "$mod SHIFT, e, exit"
          "$mod SHIFT, l, exec, ${pkgs.hyprlock}/bin/hyprlock"
        ];
      };
    };
  };
}
