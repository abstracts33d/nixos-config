{ inputs, config, ... }:

let
  user = config.hostSpec.username;
in
{
  nix-homebrew = {
    inherit user;
    enable = true;
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
      "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
      "nikitabobko/homebrew-tap" = inputs.nikitabobko-homebrew-tap;
    };
    mutableTaps = false;
    autoMigrate = true;
  };
}
