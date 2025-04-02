{
  config,
  pkgs,
  lib,
  ...
}: let
  hS = config.hostSpec;
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
in {
  config = lib.mkIf (hS.useGreetd) {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${tuigreet} --time --remember --cmd Hyprland";
          user = "greeter";
        };
      };
    };

    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal"; # Without this errors will spam on screen
      # Without these bootlogs will spam on screen
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };

    #environment.etc."greetd/environments".text = ''
    #  Hyprland
    #  fish
    #  bash
    #'';

    security.pam.services.greetd.enableGnomeKeyring = true;
  };
}
