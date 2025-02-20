{ user, config, pkgs, ... }:

let
  xdg_configHome = "${config.users.users.${user}.home}/.config";
  xdg_dataHome   = "${config.users.users.${user}.home}/.local/share";
  xdg_stateHome  = "${config.users.users.${user}.home}/.local/state"; in
{
#  "${xdg_configHome}/zsh/aliases.zsh" = {
#    text = builtins.readFile ./config/zsh/aliases.zsh;
#  };
#  "${xdg_configHome}/zsh/functions.zsh" = {
#    text = builtins.readFile ./config/zsh/functions.zsh;
#  };
}
