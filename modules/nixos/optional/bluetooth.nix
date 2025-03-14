{ config, lib, ... }:
{
  options = {
    bluetooth = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
    };
  };

  config = lib.mkIf (config.bluetooth.enable) {
    # Enables support for Bluetooth
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    # Enable Bluetooth support
    services.blueman.enable = true;
  };
}
