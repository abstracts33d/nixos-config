{ config, lib, ... }:
let
  home = config.hostSpec.home;
  xdg_configHome = "${home}/.config";
in
{
  home.file = lib.mkMerge [
    {
      "${xdg_configHome}/karabiner/karabiner.json" = {
        text = builtins.readFile ../config/karabiner.json;
      };
    }
  ];
}
