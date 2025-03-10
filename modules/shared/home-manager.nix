{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    (lib.custom.relativeToRoot "modules/shared/host-spec.nix")
    ./hm
  ];
}
