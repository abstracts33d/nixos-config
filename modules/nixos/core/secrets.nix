{
  config,
  inputs,
  ...
}:

let
  cfg = config.hostSpec;
in
{
  age = {
    identityPaths = [
      "${cfg.home}/.ssh/id_ed25519"
    ];

    secrets = {
      "github-ssh-key" = {
        symlink = false;
        path = "${cfg.home}/.ssh/id_github_ed25519";
        file = "${inputs.secrets}/github-ssh-key.age";
        mode = "600";
        owner = "${cfg.username}";
        group = "wheel";
      };

      "github-signing-key" = {
        symlink = false;
        path = "${cfg.home}/.ssh/pgp_github.key";
        file = "${inputs.secrets}/github-signing-key.age";
        mode = "600";
        owner = "${cfg.username}";
        group = "wheel";
      };
    };
  };
}
