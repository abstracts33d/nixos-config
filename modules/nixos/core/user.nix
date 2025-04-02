{
  config,
  pkgs,
  lib,
  ...
}: let
  hS = config.hostSpec;
  keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB+qnpVT15QebM41WFgwktTMP6W/KXymb8gxNV0bu5dw"];
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.users = {
    ${hS.username} = {
      isNormalUser = true;
      extraGroups = lib.flatten [
        "wheel"
        (ifTheyExist [
          "audio"
          "video"
          "docker"
          "git"
          "networkmanager"
        ])
      ];
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = keys;
    };

    root = {
      openssh.authorizedKeys.keys = keys;
    };
  };
}
