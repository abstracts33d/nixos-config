{config, ...}: let
  hS = config.hostSpec;
in {
  programs.git = {
    settings = {
      user = {
        name = hS.githubUser;
        email = hS.githubEmail;
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
    enable = true;
    ignores = ["*.swp"];

    signing = {
      format = "openpgp";
      signByDefault = true;
      key = "77C21CC574933465";
    };
    lfs = {
      enable = true;
    };
  };
}
