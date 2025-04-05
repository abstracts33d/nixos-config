{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  imports = lib.flatten [
    inputs.disko.nixosModules.disko
    inputs.home-manager.nixosModules.home-manager
    inputs.agenix.nixosModules.default
    {
      environment.systemPackages = [inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default];
    }
    ./common
    (map lib.custom.relativeToRoot [
      "modules/common"
      "modules/nixos"
    ])
  ];

  # Manages keys and such
  programs = {
    gnupg.agent.enable = true;

    # Needed for anything GTK related
    dconf.enable = true;

    # No matter what environment we are in we want these tools for root, and the user(s)
    git.enable = true;

    # My shell
    zsh.enable = true;
  };

  services = {
    # X11 settings
    xserver = {
      xkb.layout = "us";
    };

    # Better support for general peripherals
    libinput.enable = true;

    # Let's be able to SSH into this machine
    openssh.enable = true;

    # Mount, trash, and other functionalities
    gvfs.enable = true;

    # Thumbnail support for images
    tumbler.enable = true;

    # Disable CUPS printing
    printing.enable = false;

    # Enable devmon for device management
    devmon.enable = true;
  };

  # Enable PipeWire for sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true; # if not already enabled
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Video support
  hardware = {
    graphics.enable = true;
    # nvidia.modesetting.enable = true;

    # Crypto wallet support
    ledger.enable = true;
  };

  # Add docker daemon
  virtualisation.docker.enable = true;
  virtualisation.docker.logDriver = "json-file";

  fonts.packages = with pkgs; [
    nerd-fonts.meslo-lg
    dejavu_fonts
    jetbrains-mono
    font-awesome
    noto-fonts
    noto-fonts-emoji
  ];

  environment.systemPackages = with pkgs; [
    gitAndTools.gitFull
    inetutils
  ];

  system.stateVersion = "21.05"; # Don't change this
}
