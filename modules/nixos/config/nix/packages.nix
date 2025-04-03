{
  hostSpec,
  pkgs,
}:
with pkgs; let
  hS = hostSpec;
  commonPackages = import ../../../common/config/nix/packages.nix {inherit hostSpec pkgs;};
  hostPackages = import ../../../../hosts/nixos/${hS.hostName}/packages.nix {
    inherit hostSpec pkgs;
  };
in
  commonPackages
  ++ hostPackages
  ++ [
    # Text and terminal utilities
    tree
    unixtools.ifconfig
    unixtools.netstat

    # File and system utilities
    xdg-utils
  ]
  ++ lib.optionals (hS.isGraphical) [
    # Documents
    # libreoffice

    # Audio
    vlc
    pavucontrol

    # Desktop
    flameshot # Screenshot and recording tools
    zathura # PDF viewer
  ]
  ++ lib.optionals (hS.isDev) [
    # Testing and development tools
    direnv
    postgresql
  ]
  ++ lib.optionals (hS.isDev && hS.isGraphical) [
    # Dev
    vscode
    # jetbrains.ruby-mine
    # slack
  ]
