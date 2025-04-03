{pkgs, ...}: {

  nixpkgs.overlays = [
     (
       final: prev: {
         tmux = prev.tmux.overrideAttrs (
           old: {
             version = "3.4";
             src = prev.fetchFromGitHub {
               owner = "tmux";
               repo = "tmux";
               rev = "3.4";
               version = "3.4";
               hash = "sha256-RX3RZ0Mcyda7C7im1r4QgUxTnp95nfpGgQ2HRxr0s64=";
             };
             patches = [
               (prev.fetchpatch {
                 url = "https://github.com/tmux/tmux/commit/2d1afa0e62a24aa7c53ce4fb6f1e35e29d01a904.diff";
                 hash = "sha256-mDt5wy570qrUc0clGa3GhZFTKgL0sfnQcWJEJBKAbKs=";
               })
               # this patch is designed for android but FreeBSD exhibits the same error for the same reason
               (prev.fetchpatch {
                 url = "https://github.com/tmux/tmux/commit/4f5a944ae3e8f7a230054b6c0b26f423fa738e71.patch";
                 hash = "sha256-HlUeU5ZicPe7Ya8A1HpunxfVOE2BF6jOHq3ZqTuU5RE=";
               })
               # https://github.com/tmux/tmux/issues/3983
               # fix tmux crashing when neovim is used in a ssh session
               (prev.fetchpatch {
                 url = "https://github.com/tmux/tmux/commit/aa17f0e0c1c8b3f1d6fc8617613c74f07de66fae.patch";
                 hash = "sha256-jhWGnC9tsGqTTA5tU+i4G3wlwZ7HGz4P0UHl17dVRU4=";
               })
               # https://github.com/tmux/tmux/issues/3905
               # fix tmux hanging on shutdown
               (prev.fetchpatch {
                 url = "https://github.com/tmux/tmux/commit/3823fa2c577d440649a84af660e4d3b0c095d248.patch";
                 hash = "sha256-FZDy/ZgVdwUAam8g5SfGBSnMhp2nlHHfrO9eJNIhVPo=";
               })
             ];
           }
         );
       }
     )
   ];

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



#      #
#      # ████████╗███╗   ███╗██╗   ██╗██╗  ██╗
#      # ╚══██╔══╝████╗ ████║██║   ██║╚██╗██╔╝
#      #    ██║   ██╔████╔██║██║   ██║ ╚███╔╝
#      #    ██║   ██║╚██╔╝██║██║   ██║ ██╔██╗
#      #    ██║   ██║ ╚═╝ ██║╚██████╔╝██╔╝ ██╗
#      #    ╚═╝   ╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝
#      #
#
#      # Tmux general options
#      set -g default-terminal "screen-256color"
#      set -g detach-on-destroy off  # don't exit from tmux when closing a session
#      set -g history-limit 1000000 # increase history size (from 2,000)
#      setw -g mode-keys vi # Acts like vim
#      set -s escape-time 0 # Set minimun escape time
#      bind-key x kill-pane # skip "kill-pane 1? (y/n)" prompt
#      # Resize to largest window
#      setw -g aggressive-resize
#      setw -g window-size largest
#      # # Contiuum options
#      # set -g @continuum-restore 'on'
#      set -g status-interval 5
#      #Capptuccin options
#      set -g @catppuccin_flavor 'macchiato'
#      set -g @catppuccin_window_status_style "rounded"
#      set -g @catppuccin_window_default_text "#W"
#      set -g @catppuccin_window_current_text " #W" #"#T"
#      # Renumber panes and index from 1
#      set -g base-index 1
#      setw -g pane-base-index 1
#      set -g renumber-windows on
#      # Status bar options
#      set -g status-position top
#      # Mouse focus and visual activity
#      setw -g monitor-activity on
#      set -g visual-activity on
#      setw -g mouse on
#      set-option -g focus-events on
#
#      # Make the status line pretty and add some modules
#      set -g status-right-length 100
#      set -g status-left-length 100
#      set -g status-left ""
#      set -g status-right "#{E:@catppuccin_status_application}"
#      set -agF status-right "#{E:@catppuccin_status_cpu}"
#      set -ag status-right "#{E:@catppuccin_status_session}"
#      set -ag status-right "#{E:@catppuccin_status_uptime}"
#      #
#      # Mappings
#      #
#      # Remap prefix from 'C-b' to 'C-a'
#      unbind C-b
#      set-option -g prefix C-a
#      bind-key C-a send-prefix
#      # Map prefix C-l to clear-screen
#      bind C-l send-keys 'C-l'
#      # Reload tmux configuration
#      unbind r
#      bind r source-file ~/.tmux.conf \; display-message "~/.tmux.conf reloaded"
#      # Fix home andend keys
#      bind-key -n Home send Escape "OH"
#      bind-key -n End send Escape "OF"
#      # Split panes like vim
#      unbind %
#      unbind '"'
#      bind s split-window -h -c "#{pane_current_path}"
#      bind v split-window -v -c "#{pane_current_path}"
#      # Vim copy mode
#      bind -T copy-mode-vi v send -X begin-selection
#      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"
#      bind P paste-buffer
#      bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "pbcopy"
#      bind-key -T copy-mode-vi 'C-h' select-pane -L
#      bind-key -T copy-mode-vi 'C-j' select-pane -D
#      bind-key -T copy-mode-vi 'C-k' select-pane -U
#      bind-key -T copy-mode-vi 'C-l' select-pane -R
#      # Map resize panes
#      bind -r H resize-pane -L 5
#      bind -r J resize-pane -D 5
#      bind -r K resize-pane -U 5
#      bind -r L resize-pane -R 5
#      #
#      # List of plugins
#      #
#      set -g @plugin 'tmux-plugins/tpm'
#      set -g @plugin 'tmux-plugins/tmux-sensible'
#      set -g @plugin 'christoomey/vim-tmux-navigator'
#      set -g @plugin 'tmux-plugins/tmux-resurrect'
#      set -g @plugin 'tmux-plugins/tmux-continuum'
#      set -g @plugin 'tmux-plugins/tmux-cpu'
#      set -g @plugin 'jeffnguyen695/tmux-zoxide-session'
#      set -g @plugin 'catppuccin/tmux#v2.1.2'
#      #
#      # Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
#      #
#      run '~/.tmux/plugins/tpm/tpm'
    '';
  };
}
