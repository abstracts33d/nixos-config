{ config, lib, ... }:

let
  user = config.hostSpec.user;
in
{
  config = lib.mkIf (config.hyprland.enable) {
    home-manager.users.${user} = {
      programs.tofi = {
        enable = true;
      };
    };
  };
}
