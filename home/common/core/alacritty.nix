{lib, ...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      cursor = {
        style = "Block";
      };

      window = {
        opacity = lib.mkForce 0.8;
      };

      font.normal.family = lib.mkForce "MesloLGS NF";
    };
  };
}
