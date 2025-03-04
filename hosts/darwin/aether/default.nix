{ inputs, config, inputs, pkgs, agenix, ... }:
{
  imports = [
    "../darwin"
  ];

  hostSpec = {
    hostName = "aether";
    username = "s33d";
    githubUser = "abstracts33d";
    githubEmail = "abstract.s33d@gmail.com";
  };
}
