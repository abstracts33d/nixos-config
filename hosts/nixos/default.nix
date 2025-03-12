{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:

let
  user = config.hostSpec.username;
in
{
  imports = lib.flatten [
    inputs.disko.nixosModules.disko
    inputs.home-manager.nixosModules.home-manager
    inputs.agenix.nixosModules.default
    ./common
    (map lib.custom.relativeToRoot [
      "modules/nixos/core"
      "modules/nixos/optional"
      "modules/shared"
    ])
  ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 42;
      };
      efi.canTouchEfiVariables = true;
    };
    initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "nvme"
      "usbhid"
      "usb_storage"
      "sd_mod"
    ];
    # Uncomment for AMD GPU
    # initrd.kernelModules = [ "amdgpu" ];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "uinput" ];
  };

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking = {
    hostName = config.hostSpec.hostName; # Define your hostname.
    useDHCP = false;
    interfaces."${config.hostSpec.networking.interface}".useDHCP = true;
  };

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
    libinput.enable = true; # Better support for general peripherals

    openssh.enable = true; # Let's be able to SSH into this machine

    gvfs.enable = true; # Mount, trash, and other functionalities
    tumbler.enable = true; # Thumbnail support for images
  };

  # Enable CUPS to print documents
  # services.printing.enable = true;
  # services.printing.drivers = [ pkgs.brlaser ]; # Brother printer driver

  # Enable sound
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

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

  # Modules options
  theme = {
    enable = true;
    nix-config = {
      enable = true;
      # autoEnable = false;

      # If stylix.base16Scheme is undeclared, Stylix generates a color scheme based on the wallpaper
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";

      image = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/orangci/walls-catppuccin-mocha/refs/heads/master/cool.jpg";
        sha256 = "+gmixlxI+gTrWKq5Gnb7yaj/V0JWIO6dlk6uESeJ3ho=";
      };

      polarity = "dark";

      fonts = {
        serif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Serif";
        };

        sansSerif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Sans";
        };

        monospace = {
          package = pkgs.nerd-fonts.meslo-lg;
          name = "MesloLG NF";
        };

        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };
      };
    };
    hm-config = {
      programs.firefox.profiles = {
        my-profile.extensions.force = true;
      };

      stylix = {
        targets = {
          firefox = {
            colorTheme.enable = true;
            firefoxGnomeTheme.enable = true;
            profileNames = [ "my-profile" ];
          };

          vscode.profileNames = [ "my-profile" ];
        };
      };
    };
  };

  system.stateVersion = "21.05"; # Don't change this
}
