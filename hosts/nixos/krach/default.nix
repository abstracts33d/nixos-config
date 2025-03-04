{ inputs, config, inputs, pkgs, agenix, ... }:
{
  imports = [
    "../nixos"
  ];

  hostSpec = {
    hostName = "krach";
    username = "s33d";
    githubUser = "abstracts33d";
    githubEmail = "abstract.s33d@gmail.com";
    networking = {
      interface = "enp0s1";
    };
  };
}

