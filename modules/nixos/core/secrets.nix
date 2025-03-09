{ config, pkgs, agenix, inputs, ... }:

let
  user = config.hostSpec.username;
  home = config.hostSpec.home;
in
{
  age = {
    identityPaths = [
      "${home}/.ssh/id_ed25519"
    ];

    secrets = {
      "github-ssh-key" = {
        symlink = false;
        path = "${home}/.ssh/id_github_ed25519";
        file =  "${inputs.secrets}/github-ssh-key.age";
        mode = "600";
        owner = "${user}";
        group = "wheel";
      };

#      "github-signing-key" = {
#        symlink = false;
#        path = "${home}/.ssh/pgp_github.key";
#        file =  "${inputs.secrets}/github-signing-key.age";
#        mode = "600";
#        owner = "${user}";
#        group = "wheel";
#      };
    };
  };
}
