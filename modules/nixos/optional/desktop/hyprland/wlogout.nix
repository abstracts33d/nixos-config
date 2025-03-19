{
  config,
  lib,
  ...
}:

let
  cfg = config.hostSpec;
in
{
  config = lib.mkIf (config.hyprland.enable) {
    home-manager.users.${cfg.username} = {
      programs.wlogout = {
        enable = true;
      };
    };
  };
}
