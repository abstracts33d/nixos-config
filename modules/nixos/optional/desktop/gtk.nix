{ config, lib, ... }:

let
  user = config.hostSpec.username;
in
{
  config = lib.mkIf (config.hyprland.enable) {
    home-manager.users.${user} = {
      gtk = {
        enable = true;
      };
    };
  };
}
