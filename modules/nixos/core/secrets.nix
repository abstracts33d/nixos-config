{
  config,
  inputs,
  ...
}: let
  hS = config.hostSpec;
in {
  age = {
    identityPaths = [
      "/persist/home/${hS.userName}/.ssh/id_ed25519"
      "${hS.home}/.ssh/id_ed25519"
    ];

    secrets = {
      "github-ssh-key" = {
        symlink = false;
        path = "${hS.home}/.ssh/id_ed25519";
        file = "${inputs.secrets}/github-ssh-key.age";
        mode = "600";
        owner = "${hS.userName}";
        group = "wheel";
      };

      "github-signing-key" = {
        symlink = false;
        path = "${hS.home}/.ssh/pgp_github.key";
        file = "${inputs.secrets}/github-signing-key.age";
        mode = "600";
        owner = "${hS.userName}";
        group = "wheel";
      };
    };
  };
}
