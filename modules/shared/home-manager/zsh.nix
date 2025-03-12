{ pkgs, ... }:

{
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

    profileExtra = ''
      setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
      setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
      setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
      setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
    '';

    # TODO check if better imported via pkgs
    # TODO add fzf
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

      # Define variables for directories
      export PATH=$HOME/.pnpm-packages/bin:$HOME/.pnpm-packages:$PATH
      export PATH=$HOME/.npm-packages/bin:$HOME/bin:$PATH
      export PATH=$HOME/.local/share/bin:$PATH

      # Remove history data we don't want to see
      export HISTIGNORE="pwd:ls:cd"

      # Set editor default keymap to emacs (`-e`) or vi (`-v`)
      bindkey -v

      source ~/.config/zsh/aliases.zsh
      source ~/.config/zsh/functions.zsh
    '';

    initExtra = ''
      # init zoxide
      eval "$(zoxide init zsh)"

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
