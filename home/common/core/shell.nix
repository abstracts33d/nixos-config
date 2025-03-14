{
  config,
  ...
}:

{
  # TODO vim tmux

  #
  #  programs.vim = {
  #    enable = true;
  #    plugins = with pkgs.vimPlugins; [
  #      vim-airline
  #      vim-airline-themes
  #      vim-startify
  #      vim-tmux-navigator
  #    ];
  #    settings = {
  #      ignorecase = true;
  #    };
  #    extraConfig = ''
  #      "" General
  #      set number
  #      set history=1000
  #      set nocompatible
  #      set modelines=0
  #      set encoding=utf-8
  #      set scrolloff=3
  #      set showmode
  #      set showcmd
  #      set hidden
  #      set wildmenu
  #      set wildmode=list:longest
  #      set cursorline
  #      set ttyfast
  #      set nowrap
  #      set ruler
  #      set backspace=indent,eol,start
  #      set laststatus=2
  #      set clipboard=autoselect
  #
  #      " Dir stuff
  #      set nobackup
  #      set nowritebackup
  #      set noswapfile
  #      set backupdir=~/.config/vim/backups
  #      set directory=~/.config/vim/swap
  #
  #      " Relative line numbers for easy movement
  #      set relativenumber
  #      set rnu
  #
  #      "" Whitespace rules
  #      set tabstop=8
  #      set shiftwidth=2
  #      set softtabstop=2
  #      set expandtab
  #
  #      "" Searching
  #      set incsearch
  #      set gdefault
  #
  #      "" Statusbar
  #      set nocompatible " Disable vi-compatibility
  #      set laststatus=2 " Always show the statusline
  #      let g:airline_theme='bubblegum'
  #      let g:airline_powerline_fonts = 1
  #
  #      "" Local keys and such
  #      let mapleader=","
  #      let maplocalleader=" "
  #
  #      "" Change cursor on mode
  #      :autocmd InsertEnter * set cul
  #      :autocmd InsertLeave * set nocul
  #
  #      "" File-type highlighting and configuration
  #      syntax on
  #      filetype on
  #      filetype plugin on
  #      filetype indent on
  #
  #      "" Paste from clipboard
  #      nnoremap <Leader>, "+gP
  #
  #      "" Copy from clipboard
  #      xnoremap <Leader>. "+y
  #
  #      "" Move cursor by display lines when wrapping
  #      nnoremap j gj
  #      nnoremap k gk
  #
  #      "" Map leader-q to quit out of window
  #      nnoremap <leader>q :q<cr>
  #
  #      "" Move around split
  #      nnoremap <C-h> <C-w>h
  #      nnoremap <C-j> <C-w>j
  #      nnoremap <C-k> <C-w>k
  #      nnoremap <C-l> <C-w>l
  #
  #      "" Easier to yank entire line
  #      nnoremap Y y$
  #
  #      "" Move buffers
  #      nnoremap <tab> :bnext<cr>
  #      nnoremap <S-tab> :bprev<cr>
  #
  #      "" Like a boss, sudo AFTER opening the file to write
  #      cmap w!! w !sudo tee % >/dev/null
  #
  #      let g:startify_lists = [
  #        \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
  #        \ { 'type': 'sessions',  'header': ['   Sessions']       },
  #        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      }
  #        \ ]
  #
  #      let g:startify_bookmarks = [
  #        \ '~/.local/share/src',
  #        \ ]
  #
  #      let g:airline_theme='bubblegum'
  #      let g:airline_powerline_fonts = 1
  #    '';
  #  };
  #
  #
  #  programs.tmux = {
  #    enable = true;
  #    plugins = with pkgs.tmuxPlugins; [
  #      vim-tmux-navigator
  #      yank
  #      prefix-highlight
  #      {
  #        plugin = power-theme;
  #        extraConfig = ''
  #          set -g @tmux_power_theme 'gold'
  #        '';
  #      }
  #      {
  #        plugin = resurrect; # Used by tmux-continuum
  #
  #        # Use XDG data directory
  #        # https://github.com/tmux-plugins/tmux-resurrect/issues/348
  #        extraConfig = ''
  #          set -g @resurrect-dir '$HOME/.cache/tmux/resurrect'
  #          set -g @resurrect-capture-pane-contents 'on'
  #          set -g @resurrect-pane-contents-area 'visible'
  #        '';
  #      }
  #      {
  #        plugin = continuum;
  #        extraConfig = ''
  #          set -g @continuum-restore 'on'
  #          set -g @continuum-save-interval '5' # minutes
  #        '';
  #      }
  #    ];
  #    terminal = "screen-256color";
  #    prefix = "C-a";
  #    escapeTime = 10;
  #    historyLimit = 50000;
  #    extraConfig = ''
  #      # Remove Vim mode delays
  #      set -g focus-events on
  #
  #      # Enable full mouse support
  #      set -g mouse on
  #
  #      # -----------------------------------------------------------------------------
  #      # Key bindings
  #      # -----------------------------------------------------------------------------
  #
  #      # Unbind default keys
  #      unbind C-b
  #      unbind '"'
  #      unbind %
  #
  #      # Split panes, vertical or horizontal
  #      bind-key x split-window -v
  #      bind-key v split-window -h
  #
  #      # Move around panes with vim-like bindings (h,j,k,l)
  #      bind-key -n M-k select-pane -U
  #      bind-key -n M-h select-pane -L
  #      bind-key -n M-j select-pane -D
  #      bind-key -n M-l select-pane -R
  #
  #      # Smart pane switching with awareness of Vim splits.
  #      # This is copy paste from https://github.com/christoomey/vim-tmux-navigator
  #      is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
  #        | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
  #      bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
  #      bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
  #      bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
  #      bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
  #      tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
  #      if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
  #        "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
  #      if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
  #        "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"
  #
  #      bind-key -T copy-mode-vi 'C-h' select-pane -L
  #      bind-key -T copy-mode-vi 'C-j' select-pane -D
  #      bind-key -T copy-mode-vi 'C-k' select-pane -U
  #      bind-key -T copy-mode-vi 'C-l' select-pane -R
  #      bind-key -T copy-mode-vi 'C-\' select-pane -l
  #    '';
  #  };
}
