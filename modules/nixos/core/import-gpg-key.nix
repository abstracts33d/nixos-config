{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.hostSpec;
  # These files are generated when secrets are decrypted at build time
  gpgKeys = [
    "${cfg.home}/.ssh/pgp_github.key"
    "${cfg.home}/.ssh/pgp_github.pub"
  ];
in
{
  home-manager.users.${cfg.username} = {
    # This installs my GPG signing keys for Github
    systemd.user.services.gpg-import-keys = {
      Unit = {
        Description = "Import gpg keys";
        After = [ "gpg-agent.socket" ];
      };

      Service = {
        Type = "oneshot";
        ExecStart = toString (
          pkgs.writeScript "gpg-import-keys" ''
            #! ${pkgs.runtimeShell} -el
            ${lib.optionalString (gpgKeys != [ ]) ''
              ${pkgs.gnupg}/bin/gpg --import ${lib.concatStringsSep " " gpgKeys}
            ''}
          ''
        );
      };

      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
