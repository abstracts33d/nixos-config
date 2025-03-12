{ inputs, config, pkgs, lib, ... }:

let
  user = config.hostSpec.username;
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
in
{
  config = lib.mkIf (config.hyprland.enable) {
    services.xserver.displayManager.gdm.enable = true;

    security.polkit.enable = true;
    services = {
      gvfs.enable = true; # Nautilus
      devmon.enable = true;
      udisks2.enable = true;
      upower.enable = true;
      power-profiles-daemon.enable = true;
      accounts-daemon.enable = true;
      gnome = {
        sushi.enable = true; # Sushi, a quick previewer for nautilus
        evolution-data-server.enable = true;
        glib-networking.enable = true;
        gnome-keyring.enable = true;
        gnome-online-accounts.enable = true;
      };
    };

   xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk]; # gtk portal needed to make gtk apps happy
    };

    systemd = {
      user.services.polkit-gnome-authentication-agent-1 = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = ["graphical-session.target"];
        wants = ["graphical-session.target"];
        after = ["graphical-session.target"];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
    };
  };
}
