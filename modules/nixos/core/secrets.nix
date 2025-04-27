{
  config,
  inputs,
  ...
}: let
  hS = config.hostSpec;
in {
  age = {
    identityPaths = [
      "${hS.home}/.keys/id_ed25519"
      "/persist${hS.home}/.keys/id_ed25519"
    ];

    secrets = {
      "github-ssh-key" = {
        symlink = true;
        path = if (hS.isImpermanent) then "/persist${hS.home}/.ssh/id_ed25519" else "${hS.home}/.ssh/id_ed25519";
        file = "${inputs.secrets}/github-ssh-key.age";
        mode = "600";
        owner = "${hS.userName}";
        group = "wheel";
      };

      "github-signing-key" = {
        symlink = true;
        path =  if (hS.isImpermanent) then "/persist${hS.home}/.ssh/pgp_github.key" else "${hS.home}/.ssh/pgp_github.key";
        file = "${inputs.secrets}/github-signing-key.age";
        mode = "600";
        owner = "${hS.userName}";
        group = "wheel";
      };
    };
  };
}
