{ config, ... }:

let
  cfg = config.hostSpec;
in
{
  home-manager.users.${cfg.username} = {
    gtk = {
      enable = true;
    };
  };
}
