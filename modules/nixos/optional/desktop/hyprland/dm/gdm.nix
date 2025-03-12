{ config, lib, ... }:
{
#  options = {
#    gdm = {
#      enable = lib.mkOption {
#        type = lib.types.bool;
#        default = false;
#      };
#    };
#  };
#
#  config = lib.mkIf (config.gdm.enable) {
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

#    security.pam.services.gdm.enableGnomeKeyring = true;
#  };
}
