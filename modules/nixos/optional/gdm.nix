{ config, lib, ... }:
let
  hS = config.hostSpec;
in
{
  config = lib.mkIf (hS.useGdm) {
    services.xserver.displayManager.gdm.enable = true;

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
        gnome-online-accounts.enable = true;
      };
    };

    security.pam.services.gdm.enableGnomeKeyring = true;
  };
}
