{
  config,
  ...
}:
let
  user = config.hostSpec.username;
in
{
  programs.vscode = {
    enable = true;
  };
}
