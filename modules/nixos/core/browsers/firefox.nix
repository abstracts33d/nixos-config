{
  config,
  ...
}:
let
  hS = config.hostSpec;
in
{
  home-manager.users.${hS.username} = {
    programs.firefox = {
      enable = true;
    };
  };
}
