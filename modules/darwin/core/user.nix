{
  config,
  pkgs,
  ...
}:

let
  user = config.hostSpec.username;
in
{
  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };
}
