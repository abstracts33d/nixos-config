{
  config,
  ...
}:
let
  cfg = config.hostSpec;
in
{
  home-manager.users.${cfg.username} = {
    programs.firefox = {
      enable = true;
    };
  };
}
