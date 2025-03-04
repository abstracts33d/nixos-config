{ inputs, config, pkgs, ... }:

let user = config.hostSpec.username;
    keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOk8iAnIaa1deoc7jw8YACPNVka1ZFJxhnU4G74TmS+p" ]; in
{
  imports = [
    inputs.disko.nixosModules.disko
    inputs.home-manager.nixosModules.home-manager
    ../../modules/nixos/disk-config.nix
    ../../modules/nixos/home-manager.nix
    ../../modules/shared
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
    initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
    # Uncomment for AMD GPU
    # initrd.kernelModules = [ "amdgpu" ];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "uinput" ];
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking = {
    hostName = config.hostSpec.hostName; # Define your hostname.
    useDHCP = false;
    interfaces.config.hostSpec.networking.interface.useDHCP = true;
  };

  nix = {
    nixPath = [ "nixos-config=/home/${user}/.local/share/src/nixos-config:/etc/nixos" ];
    settings = {
      allowed-users = [ "${user}" ];
      trusted-users = [ "@admin" "${user}" ];
      substituters = [ "https://nix-community.cachix.org" "https://cache.nixos.org" ];
      trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
    };

    package = pkgs.nix;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Manages keys and such
  programs = {
    gnupg.agent.enable = true;

    # Needed for anything GTK related
    dconf.enable = true;

    # My shell
    zsh.enable = true;
  };

  # Enable Window Manager
  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };

  services = {
    xserver = {
      enable = true;

      # Uncomment these for AMD or Nvidia GPU
      # videoDrivers = [ "amdgpu" ];
      # videoDrivers = [ "nvidia" ];

      # Uncomment this for Nvidia GPU
      # This helps fix tearing of windows for Nvidia cards
      # services.xserver.screenSection = ''
      #   Option       "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
      #   Option       "AllowIndirectGLXProtocol" "off"
      #   Option       "TripleBuffer" "on"
      # '';

      xkb = {
        layout = "us";
      };
    };

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

  # It's me
  users.users = {
    ${user} = {
      isNormalUser = true;
      extraGroups = [
        "wheel" # Enable ‘sudo’ for the user.
        "docker"
      ];
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = keys;
    };

    root = {
      openssh.authorizedKeys.keys = keys;
    };
  };

  # Don't require password for users in `wheel` group for these commands
  security.sudo = {
    enable = true;
    extraRules = [{
      commands = [
       {
         command = "${pkgs.systemd}/bin/reboot";
         options = [ "NOPASSWD" ];
        }
      ];
      groups = [ "wheel" ];
    }];
  };

  fonts.packages = with pkgs; [
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
