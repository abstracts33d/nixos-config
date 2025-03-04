{ nixpkgs, ... }:
{
  imports = [
    ../../darwin
  ];

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-darwin";

  hostSpec = {
    hostName = "aether";
    username = "s33d";
    githubUser = "abstracts33d";
    githubEmail = "abstract.s33d@gmail.com";
  };
}
