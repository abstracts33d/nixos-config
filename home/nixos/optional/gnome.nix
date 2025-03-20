{ config, lib, ... }:
let
  hS = config.hostSpec;
in
{
  config = lib.mkIf (hS.useGnome) {
  };
}
# TODO add what's needed to HM here
#gtk = {
#  enable = true;
#
#  iconTheme = {
#    name = "Papirus-Dark";
#    package = pkgs.papirus-icon-theme;
#  };
#
#  theme = {
#    name = "palenight";
#    package = pkgs.palenight-theme;
#  };
#
#  cursorTheme = {
#    name = "Numix-Cursor";
#    package = pkgs.numix-cursor-theme;
#  };
#
#  gtk3.extraConfig = {
#    Settings = ''
#      gtk-application-prefer-dark-theme=1
#    '';
#  };
#
#  gtk4.extraConfig = {
#    Settings = ''
#      gtk-application-prefer-dark-theme=1
#    '';
#  };
#};
#
#home.sessionVariables.GTK_THEME = "palenight";
#
#dconf.settings = {
#  "org/gnome/desktop/interface" = {
#    color-scheme = "prefer-dark";
#  };
#};
#
#dconf.settings = {
#  # ...
#  "org/gnome/shell" = {
#    favorite-apps = [
#      "firefox.desktop"
#      "code.desktop"
#      "org.gnome.Terminal.desktop"
#      "spotify.desktop"
#      "virt-manager.desktop"
#      "org.gnome.Nautilus.desktop"
#    ];
#  };
#  "org/gnome/desktop/interface" = {
#    color-scheme = "prefer-dark";
#    enable-hot-corners = false;
#  };
#  "org/gnome/desktop/wm/preferences" = {
#    workspace-names = [ "Main" ];
#  };
#  "org/gnome/desktop/background" = {
#    picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/vnc-l.png";
#    picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/vnc-d.png";
#  };
#  "org/gnome/desktop/screensaver" = {
#    picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/vnc-d.png";
#    primary-color = "#3465a4";
#    secondary-color = "#000000";
#  };
#};
#
#dconf.settings = {
#  # ...
#  "org/gnome/shell" = {
#    disable-user-extensions = false;
#
#    # `gnome-extensions list` for a list
#    enabled-extensions = [
#      "user-theme@gnome-shell-extensions.gcampax.github.com"
#      "trayIconsReloaded@selfmade.pl"
#      "Vitals@CoreCoding.com"
#      "dash-to-panel@jderose9.github.com"
#      "sound-output-device-chooser@kgshank.net"
#      "space-bar@luchrioh"
#    ];
#  };
#};
#
#home.packages = with pkgs; [
#  # ...
#  gnomeExtensions.user-themes
#  gnomeExtensions.tray-icons-reloaded
#  gnomeExtensions.vitals
#  gnomeExtensions.dash-to-panel
#  gnomeExtensions.sound-output-device-chooser
#  gnomeExtensions.space-bar
#];
#
#dconf.settings = {
#  # ...
#  "org/gnome/shell" = {
#    disable-user-extensions = false;
#
#    enabled-extensions = [
#      "user-theme@gnome-shell-extensions.gcampax.github.com"
#    ];
#
#    "org/gnome/shell/extensions/user-theme" = {
#      name = "palenight";
#    };
#  };
#};
#
#home.packages = with pkgs; [
#  # ...
#  gnomeExtensions.user-themes
#  palenight-theme
#];
