{
  hostSpec,
  pkgs,
}:
with pkgs; let
  hS = hostSpec;
in [
  jetbrains.ruby-mine
  slack
]
