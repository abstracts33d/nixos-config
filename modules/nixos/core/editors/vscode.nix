{
  config,
  pkgs,
  home-manager,
  ...
}:
let
  user = config.hostSpec.username;
in
{
  #  environment.systemPackages = with pkgs; [
  #    (vscode-with-extensions.override {
  #      vscodeExtensions = with vscode-extensions; [
  #        ms-python.python
  #        ms-azuretools.vscode-docker
  #        ms-vscode-remote.remote-ssh
  #      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
  #        {
  #          name = "remote-ssh-edit";
  #          publisher = "ms-vscode-remote";
  #          version = "0.47.2";
  #          sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
  #        }
  #      ];
  #    })
  #  ];

  home-manager.users.${user} = {
    programs.vscode = {
      enable = true;
    };
  };
}
