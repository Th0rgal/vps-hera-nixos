{ pkgs, ... }: {

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_14;
    extraPlugins = with pkgs.postgresql_14.pkgs; [ postgis ];
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 10 ''
      # trust local connections
      local all all trust
      host all all ::1/128 trust
      # remote connections
      host all all 0.0.0.0/0 md5
    '';
    initialScript = pkgs.writeText "backend-initScript" ''
      CREATE ROLE eykache WITH LOGIN PASSWORD 'eykache' CREATEDB;
      CREATE DATABASE eykache;
      GRANT ALL PRIVILEGES ON DATABASE eykache TO eykache;
      ALTER USER eykache WITH SUPERUSER;
      CREATE EXTENSION IF NOT EXISTS plpgsql;
      CREATE EXTENSION postgis;
      CREATE EXTENSION postgis_raster; -- OPTIONAL
      CREATE EXTENSION postgis_topology; -- OPTIONAL
      CREATE TABLE colonies (
        id INTEGER,
        location geometry(POINT) UNIQUE
      );
      CREATE INDEX IF NOT EXISTS plots ON colonies USING GIST (location);
    '';
  };

}
