{ nixpkgs, lib, ... }:
{
  imports = [ (lib.custom.relativeToRoot "hosts/darwin") ];

  nixpkgs.hostPlatform = "aarch64-darwin";

  hostSpec = {
    hostName = "aether";
    username = "s33d";
    githubUser = "abstracts33d";
    githubEmail = "abstract.s33d@gmail.com";
  };

  # Modules options
  aerospace.enable = true;
}
