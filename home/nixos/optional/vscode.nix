{
  config,
  ...
}:

let
  hS = config.hostSpec;
in
{
  config = lib.mkIf (hS.isGraphical) {
    programs.vscode = {
      enable = true;
    };
  };
}
