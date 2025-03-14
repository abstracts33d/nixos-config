{ lib, ... }:
{
  imports = (lib.custom.scanPaths ./.) ++ [
    (lib.custom.relativeToRoot "modules/common/core/host-spec.nix")
  ];
}
