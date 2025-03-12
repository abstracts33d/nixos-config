{ pkgs, ...}:
{
  # Enable security services
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;
  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
    gnome.keyring
    gnome.seahorse
  ];
}
