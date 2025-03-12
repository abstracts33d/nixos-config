{ config, lib, ... }:

let
  user = config.hostSpec.username;
in
{
  home-manager.users.${user} = {
    gtk = {
      enable = true;
    };
  };
}
