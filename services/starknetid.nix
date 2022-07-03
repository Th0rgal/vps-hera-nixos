{ pkgs, ... }:
 {
  systemd.services.starknetid = {
    description = "PROGRAMMESWAG";
    after = [ "network.target" ];

    serviceConfig = {
      Type = "simple";
      User = "thomas";
      ExecStart = "/home/thomas/services/starknetid/env/bin/python verifier";
      WorkingDirectory = "/home/thomas/services/starknetid";
      Restart = "on-failure";
    };

    wantedBy = [ "multi-user.target" ];
  };
}
