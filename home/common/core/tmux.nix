{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    # shell = "${pkgs.fish}/bin/fish";
    sensibleOnTop = true;
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      yank
      prefix-highlight
      better-mouse-mode
      # must be before continuum edits right status bar
      {
          plugin = catppuccin;
          extraConfig = ''
          set -g @catppuccin_flavour 'mocha'
          '';
      }
      {
        plugin = resurrect; # Used by tmux-continuum

        # Use XDG data directory
        # https://github.com/tmux-plugins/tmux-resurrect/issues/348
        extraConfig = ''
          set -g @resurrect-dir '$HOME/.cache/tmux/resurrect'
          set -g @resurrect-capture-pane-contents 'on'
          set -g @resurrect-pane-contents-area 'visible'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '5' # minutes
        '';
      }
    ];
    terminal = "screen-256color";
    prefix = "C-a";
    keyMode = "vi";
    escapeTime = 1;
    historyLimit = 1000000;
    aggressiveResize = true;
    disableConfirmationPrompt = true;
    newSession = true;
    baseIndex = 1;
    mouse = true;
    focusEvents = true;
    extraConfig = ''
      set-option -g status-position top

      #
      # Mappings
      #

      # Map prefix C-l to clear-screen
      bind C-l send-keys 'C-l'

      # Reload tmux configuration
      bind r source-file ~/.tmux.conf \; display-message "~/.tmux.conf reloaded"

      # Fix home and end keys
      bind-key -n Home send Escape "OH"
      bind-key -n End send Escape "OF"

      # Split panes like vim
      unbind %
      unbind '"'
      bind s split-window -h -c "#{pane_current_path}"
      bind v split-window -v -c "#{pane_current_path}"

      # Map resize panes
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5
    '';
  };
}
