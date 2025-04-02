{ pkgs, ... }:

{
  programs.bat = {
    enable = true;
    config = {
      style = "changes,header"; # Git modifications and file header (but no grid)
    };
    extraPackages = builtins.attrValues {
      inherit (pkgs.bat-extras)

        batgrep # search through and highlight files using ripgrep
        batdiff # Diff a file against the current git index, or display the diff between to files
        batman # read manpages using bat as the formatter
        ;
    };
  };
}
