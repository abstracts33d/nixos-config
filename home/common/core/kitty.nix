{...}: {
  programs = {
    kitty = {
      enable = true;
      extraConfig = "
        background_opacity 0.95

        hide_window_decorations yes
        window_border_width 0
        draw_minimal_borders yes
        enable_audio_bell no
        scrollback_lines 250000

        map cmd+1 send_text all \\\x011
        map cmd+2 send_text all \\\x012
        map cmd+3 send_text all \\\x013
        map cmd+4 send_text all \\\x014
        map cmd+5 send_text all \\\x015
        map cmd+6 send_text all \\\x016
        map cmd+7 send_text all \\\x017
        map cmd+8 send_text all \\\x018
        map cmd+9 send_text all \\\x019
        map cmd+n send_text all \\\x01c
        map cmd+x send_text all \\\x01x
        map cmd+l send_text all \\\x01\\\x0C

        cursor_trail 3
        cursor_trail_decay 0.1 0.4
        ";
    };
  };
}
