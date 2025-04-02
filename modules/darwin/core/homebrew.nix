{ config, pkgs, lib, ... }:

let
  hS = config.hostSpec;
in
{
  homebrew = {
    enable = true;
    brews = pkgs.callPackage (lib.custom.relativeToRoot "modules/darwin/config/nix/brews.nix") { }
      ++ pkgs.callPackage (lib.custom.relativeToRoot "hosts/darwin/${hS.hostName}/brews.nix") { };
    casks = pkgs.callPackage (lib.custom.relativeToRoot "modules/darwin/config/nix/casks.nix") { }
      ++ pkgs.callPackage (lib.custom.relativeToRoot "hosts/darwin/${hS.hostName}/casks.nix") { };
    # onActivation.cleanup = "uninstall";

    # These app IDs are from using the mas CLI app
    # mas = mac app store
    # https://github.com/mas-cli/mas
    #
    # $ nix shell nixpkgs#mas
    # $ mas search <app name>
    #
    # If you have previously added these apps to your Mac App Store profile (but not installed them on this system),
    # you may receive an error message "Redownload Unavailable with This Apple ID".
    # This message is safe to ignore.
    masApps = {
      # "bitwarden" = 1352778147;
    };
  };
}
