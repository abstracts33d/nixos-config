{
  config,
  pkgs,
  lib,
  ...
}:

let
  hS = config.hostSpec;
in
{
  config = lib.mkIf (hS.useHyprland) {
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
