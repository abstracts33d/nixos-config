# Specifications For Differentiating Hosts
{
  config,
  lib,
  ...
}: {
  options.hostSpec = {
    # Data variables that don't dictate configuration settings
    username = lib.mkOption {
      type = lib.types.str;
      description = "The username of the host";
    };
    hostName = lib.mkOption {
      type = lib.types.str;
      description = "The hostname of the host";
    };
    networking = lib.mkOption {
      default = {};
      type = lib.types.attrsOf lib.types.anything;
      description = "An attribute set of networking information";
    };
    githubUser = lib.mkOption {
      type = lib.types.str;
      description = "The handle of the user";
    };
    githubEmail = lib.mkOption {
      type = lib.types.str;
      description = "The email of the user";
    };
    home = lib.mkOption {
      type = lib.types.str;
      description = "The home directory of the user";
      default = let
        hS = config.hostSpec;
      in
        if hS.isDarwin
        then "/Users/${hS.username}"
        else "/home/${hS.username}";
    };
    persistFolder = lib.mkOption {
      type = lib.types.str;
      description = "The folder to persist data if impermenance is enabled";
      default = "";
    };

    # Configuration Settings
    isMinimal = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Used to indicate a minimal host";
    };
    isServer = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Used to indicate a server host";
    };
    isDarwin = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Used to indicate a host that is darwin";
    };
    isDev = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Used to indicate a development host";
    };
    isGraphical = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Used to indicate a host that is graphical";
    };
    useGnome = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Used to indicate a host that uses a Gnome";
    };
    useHyprland = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Used to indicate a host that uses a Hyperland";
    };
    useGdm = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Used to indicate a host that uses a GDM";
    };
    useGreetd = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Used to indicate a host that uses a Ggreetd";
    };
    useAerospace = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Used to indicate a host that uses a aerospace";
    };

    # Hardware Configuration Settings
    hasBluetooth = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Used to indicate a host that has bluetooth capabilities";
    };
  };
}
