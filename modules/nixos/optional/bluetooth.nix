{ config, lib, ... }:
let
  hS = config.hostSpec;
in
{
  config = lib.mkIf (hS.hasBluetooth) {
    # Enables support for Bluetooth
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    # Enable Bluetooth support
    services.blueman.enable = true;
  };
}
