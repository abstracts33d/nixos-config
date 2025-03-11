{ ... }:

{
  programs.zsh = {
    enable = true;

    # TODO check if better imported via pkgs
    # TODO add fzf
    # TODO zsh-users/zsh-history-substring-search NOT working need as: plugin
    zplug = {
      enable = true;
      plugins = [
        { name = "Aloxaf/fzf-tab"; }
        { name = "jeffreytse/zsh-vi-mode"; }
        { name = "zsh-users/zsh-completions"; }
        { name = "zsh-users/zsh-syntax-highlighting"; }
        { name = "zdharma/fast-syntax-highlighting"; }
        # { name = "zsh-users/zsh-history-substring-search"; }
        { name = "zsh-users/zsh-autosuggestions"; }
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

      # init zoxide
      eval "$(zoxide init zsh)"

      source ~/.config/zsh/aliases.zsh
      source ~/.config/zsh/functions.zsh
    '';

    initExtra = ''
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
