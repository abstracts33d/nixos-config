{ pkgs, ... }:

{
  programs = {
    gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
        pinentryFlavor = "curses";
      };
    };
  };
}



pinentry-program /usr/bin/pinentry-tty
default-cache-ttl 34560000
max-cache-ttl 34560000

pinentry-program /opt/homebrew/bin/pinentry-mac
default-cache-ttl 34560000
max-cache-ttl 34560000
