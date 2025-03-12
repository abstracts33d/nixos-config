{ pkgs, ...}:
{
  # Enable security services
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;

  security.pam.services.gdm.enableGnomeKeyring = true;
  # security.pam.services.greetd.enableGnomeKeyring = true;

  programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.gnome.seahorse.out}/libexec/seahorse/ssh-askpass";
}
