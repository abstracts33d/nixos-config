{
  config,
  pkgs,
  ...
}:

let
  cfg = config.hostSpec;
in
{
  users.users.${cfg.username} = {
    name = "${cfg.username}";
    home = "${cfg.home}";
    isHidden = false;
    shell = pkgs.zsh;
  };
}
