{ config, ... }:

let
  hS = config.hostSpec;
in
{
  home-manager.users.${hS.username} = {
    gtk = {
      enable = true;
    };
  };
}
