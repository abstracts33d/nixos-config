{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  hS = config.hostSpec;
  keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB+qnpVT15QebM41WFgwktTMP6W/KXymb8gxNV0bu5dw"];
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.users = {
    ${hS.userName} = {
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
      hashedPasswordFile = lib.mkIf (hS.isImpermanent) "${inputs.secrets}/${hS.userName}-hashed-password-file";
    };

    root = {
      openssh.authorizedKeys.keys = keys;
      hashedPasswordFile = lib.mkIf (hS.isImpermanent) "${inputs.secrets}/hashed-password-file";
    };
  };
}
