{ lib, ... }: {
  services.openssh = {
    enable = true;
    ports = [ 9473 ];
    permitRootLogin = "no";
    passwordAuthentication = true;
  };

  networking = {
    hostName = "hera";
    nameservers = [ "1.1.1.1" "9.9.9.9" ];
    firewall = {
      enable = false;
      allowPing = true;
      allowedTCPPorts =
        [ 80 443 6000 25565 8146 5432 ]; # HTTP, SSL, TOR, MINECRAFT, SQL
    };
  };
}
