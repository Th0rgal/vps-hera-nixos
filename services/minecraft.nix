{ pkgs, ... }: {
  systemd.services.minecraft = {
    description = "PROGRAMMESWAG";
    after = [ "network.target" ];

    serviceConfig = {
      Type = "simple";
      User = "thomas";
      ExecStart = "${pkgs.adoptopenjdk-jre-openj9-bin-16}/bin/java -jar ./server.jar";
      WorkingDirectory = "/home/thomas/services/minecraft";
      Restart = "no";
    };

    environment = { JAVA_HOME = pkgs.adoptopenjdk-jre-openj9-bin-16; };

    wantedBy = [ "multi-user.target" ];
  };
}
