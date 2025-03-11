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
      #    style = "Regular";
      #  };
      #  size = 13;
      # };

      dynamic_padding = true;
      decorations = "full";
      title = "Terminal";
      class = {
        instance = "Alacritty";
        general = "Alacritty";
      };
    };
  };
}
