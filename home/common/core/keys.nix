{
  config,
  lib,
  ...
}:
let
  home = config.hostSpec.home;
in
{
  home.file = lib.mkMerge [
    {
      "${home}/.ssh/id_github_ed25519.pub" = {
        text = builtins.readFile ../config/githubPublicKey;
      };
      "${home}/.ssh/pgp_github.pub" = {
        text = builtins.readFile ../config/githubPublicSigningKey;
      };
    }
  ];
}
