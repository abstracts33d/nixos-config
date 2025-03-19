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
    home-manager.users.${cfg.user} = {
      programs.wlogout = {
        enable = true;
      };
    };
  };
}
