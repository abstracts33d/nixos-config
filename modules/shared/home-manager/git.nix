{ config, ... }:

let
  name = config.hostSpec.githubUser;
  user = config.hostSpec.username;
  email = config.hostSpec.githubEmail;
in
{
  programs.git = {
    enable = true;
    ignores = [ "*.swp" ];
    userName = name;
    userEmail = email;
    signing = {
      format = "openpgp";
      signByDefault = true;
      key = "77C21CC574933465";
    };
    lfs = {
      enable = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
      core = {
        editor = "nvim";
        autocrlf = "input";
      };
      color = {
        ui = true;
      };
      pull.rebase = true;
      push.autoSetupRemote = true;
      rebase.autoStash = true;
    };
  };
}
