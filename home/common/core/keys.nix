{
  config,
  lib,
  ...
}:
let
  hS = config.hostSpec;
in
{
  home.file = lib.mkMerge [
    {
      "${hS.home}/.ssh/pgp_github.pub" = {
        text = builtins.readFile ../config/githubPublicSigningKey;
      };
    }
  ];
}
