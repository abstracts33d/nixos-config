{
  config,
  pkgs,
  ...
}:

let
  hS = config.hostSpec;
in
{
  users.users.${hS.username} = {
    name = "${hS.username}";
    home = "${hS.home}";
    isHidden = false;
    shell = pkgs.zsh;
  };
}
