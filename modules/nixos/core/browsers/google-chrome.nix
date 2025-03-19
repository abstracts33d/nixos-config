{
  config,
  ...
}:
let
  cfg = config.hostSpec;
in
{
  home-manager.users.${cfg.username} = {
    programs.google-chrome = {
      enable = true;
    };
  };
}
