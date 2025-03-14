{
  config,
  ...
}:
let
  user = config.hostSpec.username;
in
{
  programs.google-chrome = {
    enable = true;
  };
}
