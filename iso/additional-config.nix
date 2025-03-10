{ ... }:
{
  # Enable guests addons
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  # Add ssh-key
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB+qnpVT15QebM41WFgwktTMP6W/KXymb8gxNV0bu5dw"
  ];
}
