{ pkgs, lib, ... }:

{
  homebrew = {
    enable = true;
    brews = pkgs.callPackage (lib.custom.relativeToRoot "modules/darwin/brews.nix") { };
    casks = pkgs.callPackage (lib.custom.relativeToRoot "modules/darwin/casks.nix") { };
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
