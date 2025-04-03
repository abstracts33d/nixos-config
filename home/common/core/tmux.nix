{
  config,
  pkgs,
  ...
}: let
  hS = config.hostSpec;
in {
  # link tmux file for darwin
  home = {
    file = {
      ".tmux.conf".source = config.lib.file.mkOutOfStoreSymlink "${hS.home}/.config/tmux/tmux.conf";
    };
  };

  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    # shell = "${pkgs.fish}/bin/fish";
    sensibleOnTop = false;
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      yank
      prefix-highlight
      better-mouse-mode
      cpu
      # must be before continuum edits right status bar
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor 'macchiato'
          set -g @catppuccin_window_status_style "rounded"
          set -g @catppuccin_window_default_text "#W"
          set -g @catppuccin_window_current_text " #W" #"#T"
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
            #
            # Make the status line pretty and add some modules
            #

            set -g status-position top
            set -g status-right-length 100
            set -g status-left-length 100
            set -g status-left ""
            set -g status-right "#{E:@catppuccin_status_application}"
            set -agF status-right "#{E:@catppuccin_status_cpu}"
            set -ag status-right "#{E:@catppuccin_status_session}"
            set -ag status-right "#{E:@catppuccin_status_uptime}"

            #
            # Mappings
            #

            # Map prefix C-l to clear-screen
            bind C-l send-keys 'C-l'

            # Reload tmux configuration
            unbind r
            bind r source-file ~/.config/tmux/tmux.conf \; display-message "~/.config/tmux/tmux.conf reloaded"

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
