{ pkgs, config, lib, ... }:
{
  options = {
    gnome = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
    };
  };

  config = lib.mkIf (config.gnome.enable) {
    services = {
      xserver = {
        enable = true;
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
        # Uncomment these for AMD or Nvidia GPU
        # videoDrivers = [ "amdgpu" ];
        # videoDrivers = [ "nvidia" ];

        # Uncomment this for Nvidia GPU
        # This helps fix tearing of windows for Nvidia cards
        # screenSection = ''
        #   Option       "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
        #   Option       "AllowIndirectGLXProtocol" "off"
        #   Option       "TripleBuffer" "on"
        # '';

        xkb = {
          layout = "us";
        };
      };
    };

    # Remove decorations for QT applications
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    };

    environment.gnome.excludePackages = (
      with pkgs;
      [
        gedit
        gnome-connections
        gnome-console
        gnome-photos
        gnome-tour
        snapshot
        atomix # puzzle game
        # baobab # disk usage analyzer
        cheese # webcam tool
        epiphany # web browser
        evince # document viewer
        geary # email reader
        gnome-calendar
        gnome-characters
        gnome-clocks
        gnome-contacts
        # gnome-disk-utility
        # gnome-font-viewer
        gnome-initial-setup
        gnome-logs
        gnome-maps
        gnome-music
        # gnome-shell-extensions
        # gnome-system-monitor
        gnome-terminal
        gnome-weather
        hitori # sudoku game
        iagno # go game
        simple-scan
        tali # poker game
        yelp # help viewer
      ]
    );

    programs.dconf.enable = true;

    environment.systemPackages = with pkgs; [
      gnome-tweaks
    ];
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
