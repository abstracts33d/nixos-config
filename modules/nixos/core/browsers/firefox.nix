{
  config,
  ...
}:
let
  user = config.hostSpec.username;
in
{
  home-manager.users.${user} = {
    programs.firefox = {
      enable = true;
    };
  };
}
