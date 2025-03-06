{ pkgs, ... }:

{
  homebrew = {
    enable = true;
    brews = [
    "pinentry-mac"
    "gmp" "libyaml" "openssl" "redis" "libxml2" "xz" # TODO REMOVE added for mise ruby (PostgressApp installed manually)
    ];
    casks = pkgs.callPackage ./casks.nix { };
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
