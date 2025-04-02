{config, ...}: let
  hS = config.hostSpec;
in {
  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking = {
    hostName = hS.hostName; # Define your hostname.
    useDHCP = false;
    interfaces."${hS.networking.interface}".useDHCP = true;
  };
}
