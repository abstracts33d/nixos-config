{
  config,
  ...
}:
let
  hS = config.hostSpec;
in
{
  home-manager.users.${hS.username} = {
    programs.google-chrome = {
      enable = true;
    };
  };
}
