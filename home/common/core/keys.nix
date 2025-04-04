{
  config,
  lib,
  ...
}: let
  hS = config.hostSpec;
in {
  home.file = lib.mkMerge [
    {
      "${hS.home}/.ssh/id_ed25519.pub" = {
        text = builtins.readFile ../config/githubPublicKey;
      };
      "${hS.home}/.ssh/pgp_github.pub" = {
        text = builtins.readFile ../config/githubPublicSigningKey;
      };
    }
  ];
}
