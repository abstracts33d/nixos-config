{
  config,
  pkgs,
  lib,
  ...
}:

let
  user = config.hostSpec.username;
in
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
    programs = {
      hyprland = {
        enable = true;
        xwayland.enable = true;
        withUWSM = true;
      };
    };

    # Enable Ozone Wayland support in Chromium and Electron based applications
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    };

    environment.systemPackages = with pkgs; [
      file-roller # archive manager
      nautilus # file manager
      totem # Video player

      brightnessctl
      networkmanagerapplet
      pavucontrol
      wf-recorder
    ];
  };
}
