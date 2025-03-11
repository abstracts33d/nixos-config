{ config, pkgs, lib, ... }:

let
  user = config.hostSpec.username;
in
{
  # todo filter and add dependencies
  # Required packages
  # paru -S base-devel pokemon-colorscripts-git hyprland hyprpicker hyprlock hypridle xdg-desktop-portal-hyprland-git waybar-hyprland cava kitty wofi starship wl-clipboard swww swaync tty-clock-git playerctl pavucontrol btop mpd mpd-mpris mpv mpv-mpris qt5-base qt5-wayland qt6-base qt6-wayland lsd geany bat cliphist gamemode polkit-gnome g4music wlogout visual-studio-code-bin boo-grub-git sddm-git boo-sddm-git proxzima-plymouth-git yad blueman network-manager-applet libinput-gestures light --needed
  # Optional packages
  # paru -S system76-power obs-studio wlrobs-hg v4l2loopback-dkms v4l2loopback-utils v4l-utils waydroid binder_linux-dkms chromium-wayland-vaapi qalculate-gtk qimgv-light rlr-git uget libreoffice-fresh nemo bulky --needed
  options = {
    hyprland = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
    };
  };

  config = lib.mkIf (config.hyprland.enable) {
    programs = {
      hyprland = {
        enable = true;
        xwayland.enable = true;
        withUWSM = true;
      };
    };

    home-manager.users.${user} = {
      wayland.windowManager.hyprland = {
        enable = true;
        settings = {
          "$mod" = "SUPER";

          "$terminal" = "kitty";
          "$browser" = "firefox";
          "$launcher" = "tofi-drun -c ~/.config/tofi/tofi.launcher.conf";
          "$launcher_alt" = "tofi-run -c ~/.config/tofi/tofi.launcher.conf";
          "$launcher2" = "wofi --show drun -n";
          "$launcher2_alt" = "wofi --show run -n";
          "$editor" = "code";


          bind = [
            # General
            "$mod, return, exec, $terminal"
            "$mod, a, exec, $launcher"
            "$mod, s, exec, $launcher_alt"
            "$mod, d, exec, $launcher2"
            "$mod, f, exec, $launcher2_alt"
            "$mod SHIFT, q, killactive"
            "$mod SHIFT, e, exit"
            "$mod SHIFT, l, exec, ${pkgs.hyprlock}/bin/hyprlock"
          ];
        };
      };
    };
  };
}
