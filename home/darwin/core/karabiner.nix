{
  config,
  lib,
  ...
}: let
  hS = config.hostSpec;
  xdg_configHome = "${hS.home}/.config";
in {
  home.file = lib.mkMerge [
    {
      "${xdg_configHome}/karabiner/karabiner.json" = {
        text = builtins.readFile ../config/karabiner.json;
      };
    }
  ];
}
