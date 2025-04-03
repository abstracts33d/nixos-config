{
  config,
  pkgs,
  ...
}: let
  hS = config.hostSpec;
in {
  users.users.${hS.userName} = {
    name = "${hS.userName}";
    home = "${hS.home}";
    isHidden = false;
    shell = pkgs.zsh;
  };
}
