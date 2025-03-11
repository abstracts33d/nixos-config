{ config, pkgs, lib, ... }:

let
  user = config.hostSpec.username;
in
{
  config = lib.mkIf (config.hyprland.enable) {
    home-manager.users.${user} = {
      programs.wlogout = {
        enable = true;
        layout = [
          {
            label = "lock";
            action = "${pkgs.hyprlock}/bin/hyprlock";
            text = "Lock";
            keybind = "l";
          }
          {
            label = "reboot";
            action = "systemctl reboot";
            text = "Reboot";
            keybind = "r";
          }
          {
            label = "shutdown";
            action = "systemctl poweroff";
            text = "Shutdown";
            keybind = "s";
          }
          {
            label = "logout";
            action = "hyprctl dispatch exit none";
            text = "Logout";
            keybind = "e";
          }
          {
            label = "suspend";
            action = "systemctl suspend";
            text = "Suspend";
            keybind = "u";
          }
        ];

        style = ''
          /** ********** Fonts ********** **/
          * {
            font-family: "Geist Mono", "Lato", sans-serif;
            font-size: 15px;
            font-weight: bold;
          }

          /** ********** Main Window ********** **/
          window {
            background-color: transparent;
          }

          /** ********** Buttons ********** **/
          button {
            background-color: #161925;
            color: #cdd6f4;
            border: 2px solid #282838;
            border-radius: 20px;
            background-repeat: no-repeat;
            background-position: center;
            background-size: 35%;
            transition: all 0.2s ease-in-out;
          }

          button:focus,
          button:active,
          button:hover {
            color: #FFFFFF;
            background-color: #b4befe;
            outline-style: none;
          }

          /** ********** Icons ********** **/
          #lock {
            background-image: image(url("icons/lock.png"), url("/usr/share/wlogout/icons/lock.png"));
          }

          #logout {
            background-image: image(url("icons/logout.png"), url("/usr/share/wlogout/icons/logout.png"));
          }

          #suspend {
            background-image: image(url("icons/suspend.png"), url("/usr/share/wlogout/icons/suspend.png"));
          }

          #hibernate {
            background-image: image(url("icons/hibernate.png"), url("/usr/share/wlogout/icons/hibernate.png"));
          }

          #shutdown {
            background-image: image(url("icons/shutdown.png"), url("/usr/share/wlogout/icons/shutdown.png"));
          }

          #reboot {
            background-image: image(url("icons/reboot.png"), url("/usr/share/wlogout/icons/reboot.png"));
          }
        '';
      };
    };
  };
}
