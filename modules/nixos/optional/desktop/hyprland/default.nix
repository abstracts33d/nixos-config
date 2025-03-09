{ config, lib, ... }:
{
  options = {
    hyprland = {
      enable = lib.mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = lib.mkIf (config.hyprland.enable) {
    programs = {
      hyprland = {
        enable = true;
        xwayland.enable = true;
      };
    };
  };
}
