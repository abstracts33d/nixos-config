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
      "${hS.home}/.ssh/id_ed25519_agenix"
    ];

    secrets = {
      "github-ssh-key" = {
        symlink = true;
        path = "${hS.home}/.ssh/id_github_ed25519";
        file = "${inputs.secrets}/github-ssh-key.age";
        mode = "600";
        owner = "${hS.username}";
        group = "staff";
      };

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
