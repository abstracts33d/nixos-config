{ ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      cursor = {
        style = "Block";
      };

      window = {
        opacity = 1.0;
        padding = {
          x = 24;
          y = 24;
        };
      };

      # Handled by the theme module
      # font = {
      #  normal = {
      #    family = "MesloLG NF";
      #    style = "Monospace";
      #  };
      #  size = 13;
      # };
      font.normal.style = lib.mkForce "Monospace";
    };
  };
}
