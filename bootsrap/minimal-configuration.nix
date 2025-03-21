{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./modules/common/core/host-spec.nix
    ./hosts/nixos/common/core
  ];

  # No matter what environment we are in we want these tools for root, and the user(s)
  programs.git.enable = true;

  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      wget
      curl
      rsync
      git
      ;
  };

  services = {
    qemuGuest.enable = true;
    spice-vdagentd.enable = true;
    openssh = {
      enable = true;
      ports = [ 22 ];
      settings.PermitRootLogin = "yes";
    };
  };

  # Add ssh-key
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB+qnpVT15QebM41WFgwktTMP6W/KXymb8gxNV0bu5dw"
  ];

  system.stateVersion = "21.05"; # Don't change this
}
