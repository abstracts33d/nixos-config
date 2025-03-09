{ config, ... }:
{
  options = {
    hyprland = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf (config.hyprland.enable) {
    programs = {
      hyprland = {
        enable = true;
        xwayland.enable = true;
      };
    };
  };
}
