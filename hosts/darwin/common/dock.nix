{ config, pkgs, ... }:

let
  cfg = config.hostSpec;
in
{
  # Fully declarative dock using the latest from Nix Store
  local = {
    dock = {
      enable = true;
      entries = [
        { path = "/Applications/Slack.app/"; }
        { path = "/Applications/Notion.app/"; }
        { path = "/Applications/Obsidian.app/"; }
        { path = "${pkgs.alacritty}/Applications/Alacritty.app/"; }
        { path = "/Applications/Kitty.app/"; }
        { path = "/Applications/Visual Studio Code.app/"; }
        { path = "/Applications/RubyMine.app/"; }
        { path = "/Applications/Safari.app/"; }
        { path = "/Applications/Google Chrome.app/"; }
        { path = "/Applications/Zen Browser.app/"; }
        { path = "/System/Applications/System Settings.app/"; }
        { path = "/Applications/UTM.app/"; }
        {
          path = "${config.users.users.${cfg.username}.home}/.config/";
          section = "others";
          options = "--sort name --view grid --display folder";
        }
        {
          path = "${config.users.users.${cfg.username}.home}/.local/share/";
          section = "others";
          options = "--sort name --view grid --display folder";
        }
        {
          path = "${config.users.users.${cfg.username}.home}/Downloads";
          section = "others";
          options = "--sort name --view grid --display stack";
        }
      ];
    };
  };
}
