{ lib, ... }:
{
  imports = (lib.custom.scanPaths ./.) ++ [(lib.custom.relativeToRoot "modules/shared/host-spec.nix")];
}
