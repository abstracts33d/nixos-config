{ inputs, config, pkgs, lib, ... }:

let
  user = config.hostSpec.username;
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
in
{
  config = lib.mkIf (config.hyprland.enable) {
    services.xserver.displayManager.gdm.enable = true;

    programs.gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-gnome3;
      enableSSHSupport = true;
    };

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
        glib-networking.enable = true;
#        gnome-keyring.enable = true;
        gnome-online-accounts.enable = true;
      };
    };

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk]; # gtk portal needed to make gtk apps happy
    };
  };
}
