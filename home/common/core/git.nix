{config, ...}: let
  hS = config.hostSpec;
in {
  programs.git = {
    enable = true;
    ignores = ["*.swp"];
    userName = hS.githubUser;
    userEmail = hS.githubEmail;
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
