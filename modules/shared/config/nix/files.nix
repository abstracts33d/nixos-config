{
  user,
  config,
  pkgs,
  lib,
  ...
}:

let
  xdg_configHome = "${config.users.users.${user}.home}/.config";
  xdg_dataHome = "${config.users.users.${user}.home}/.local/share";
  xdg_stateHome = "${config.users.users.${user}.home}/.local/state";
  isDarwin = config.hostSpec.isDarwin;
in
{
  ".ssh/id_github_ed25519.pub" = {
    text =  builtins.readFile ../githubPublicKey;
  };
  ".ssh/pgp_github.pub" = {
    text = builtins.readFile ../githubPublicSigningKey;
  };
  ".gnupg/gpg-agent.conf" = {
    text = builtins.readFile (lib.custom.relativeToRoot "modules/${if isDarwin then "darwin" else "nixos"}/config/gpg-agent.conf");
  };
  "${xdg_configHome}/zsh/aliases.zsh" = {
    text = builtins.readFile ../zsh/aliases.zsh;
  };
  "${xdg_configHome}/zsh/functions.zsh" = {
    text = builtins.readFile ../zsh/functions.zsh;
  };
}
