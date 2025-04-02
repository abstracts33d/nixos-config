{
  config,
  pkgs,
  lib,
  ...
}: let
  hS = config.hostSpec;
in {
  config = lib.mkIf (hS.useHyprland) {
    programs = {
      hyprland = {
        enable = true;
        xwayland.enable = true;
        withUWSM = true;
      };
    };

    environment.sessionVariables = {
      # Enable Ozone Wayland support
      NIXOS_OZONE_WL = "1";
      # Remove decorations for QT applications
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
