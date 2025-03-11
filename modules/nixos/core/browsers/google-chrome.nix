{ config, pkgs, home-manager, ... }:
let
  user = config.hostSpec.username;
in
{
  home-manager.users.${user} = {
    programs.google-chrome = {
      enable = true;
    };
  };
}
