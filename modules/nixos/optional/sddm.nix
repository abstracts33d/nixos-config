{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  hS = config.hostSpec;
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
in {
  imports = [
    inputs.sddm-sugar-candy-nix.nixosModules.default
    {
      nixpkgs = {
        overlays = [
          inputs.sddm-sugar-candy-nix.overlays.default
        ];
      };
    }
  ];

  config = lib.mkIf (hS.useSddm) {
    services.displayManager.sddm = {
      wayland = {
        enable = true;
      };
      enable = true;
      sugarCandyNix = {
        enable = true;
        settings = {
          Background = pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/orangci/walls-catppuccin-mocha/refs/heads/master/cool.jpg";
            sha256 = "g6cFnOT4GICHD7xGy28lrr2GT4gE4q6mCtWqNCweP38=";
          };
          FormPosition = "center";
          FullBlur = true;
        };
      };
    };
  };
}
