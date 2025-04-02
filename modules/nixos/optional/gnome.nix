{
  pkgs,
  config,
  lib,
  ...
}: let
  hS = config.hostSpec;
in {
  config = lib.mkIf (hS.useGnome) {
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
      };
    };

    environment.sessionVariables = {
      # Enable Ozone Wayland support
      NIXOS_OZONE_WL = "1";
      # Remove decorations for QT applications
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    };

    environment.gnome.excludePackages = (
      with pkgs; [
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
