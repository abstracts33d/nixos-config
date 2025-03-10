{ inputs, config, lib, ... }:
{
  options = {
    theme = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
    };
  };

  config = lib.mkIf (config.theme.enable) {
    imports = [
      inputs.stylix.nixosModules.stylix
    ];
  };
}
