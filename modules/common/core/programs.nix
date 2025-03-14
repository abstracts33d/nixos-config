{ ... }:

{
  # Disable compinit call in /etc/zsh
  programs = {
    zsh = {
      enableCompletion = false;
    };
  };
}
