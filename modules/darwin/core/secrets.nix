{
  config,
  inputs,
  ...
}:

let
  hS = config.hostSpec;
in
{
  age = {
    identityPaths = [
      "${hS.home}/.ssh/id_ed25519"
    ];

    secrets = {
      "github-signing-key" = {
        symlink = false;
        path = "${hS.home}/.ssh/pgp_github.key";
        file = "${inputs.secrets}/github-signing-key.age";
        mode = "600";
        owner = "${hS.username}";
      };
    };
  };
}
