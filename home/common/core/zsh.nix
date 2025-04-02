{
  config,
  lib,
  ...
}:
let
  hS = config.hostSpec;
  xdg_configHome = "${hS.home}/.config";
in
{
  home.file = lib.mkMerge [
    {
      "${xdg_configHome}/zsh/functions.zsh" = {
        text = builtins.readFile ../config/zsh/functions.zsh;
      };
      "${xdg_configHome}/zsh/aliases.zsh" = {
        text = builtins.readFile ../config/zsh/aliases.zsh;
      };
    }
  ];

  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    history = {
      size = 10000000;
      save = 10000000;
      ignoreSpace = true;
      ignoreDups = true;
      ignoreAllDups = true;
      expireDuplicatesFirst = true;
      extended = true;
      share = true;
    };

    sessionVariables = {
      LANG = "en_US.UTF-8";
      LC_ALL = "$LANG";
      GPG_TTY = "$(tty)";
      EDITOR = "nvim";
      VISUAL = "nvim";
      BROWSER = "firefox";
      WORKSPACE = "$HOME/Dev";
      GITHUB_USERNAME = "abstracts33d";
    };

    profileExtra = ''
      setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
      setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
      setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
      setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
    '';

    zplug = {
      enable = true;
      plugins = [
        { name = "Aloxaf/fzf-tab"; }
        { name = "jeffreytse/zsh-vi-mode"; }
        {
          name = "zsh-users/zsh-history-substring-search";
          tags = [ "as:plugin" ];
        }
      ];
    };

    initExtraFirst = ''
      # Profiling
      # zmodload zsh/zprof

      if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
        . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
      fi

      # Remove history data we don't want to see
      export HISTIGNORE="pwd:ls:cd"

      # Set editor default keymap to emacs (`-e`) or vi (`-v`)
      bindkey -v

      source ~/.config/zsh/aliases.zsh
      source ~/.config/zsh/functions.zsh
    '';

    initExtra = ''
      # zsh-history-substring-search
      bindkey '^[[A' history-substring-search-up
      bindkey '^[OA' history-substring-search-up
      bindkey '^[[B' history-substring-search-down
      bindkey '^[OB' history-substring-search-down

      # zsh-autosuggestions
      # set Autosuggestions key binging to alt-enter
      bindkey '\e\r' autosuggest-accept

      # Greetings
      if [ -z "$TMUX" ]
      then
        fastfetch
      else
        echo ' ☠ Loaded ☠ '
      fi

      # Profiling
      # zprof
    '';
  };
}
