{ pkgs, username, ... }:
{
  services.nginx.virtualHosts."drive.ms0503.dev" = {
    locations."/".proxyPass = "http://127.0.0.1:3000";
    reuseport = true;
  };
  users = {
    groups.drive = { };
    users = {
      "${username}".extraGroups = [
        "drive"
      ];
      drive = {
        createHome = true;
        description = "Drive server service user";
        group = "drive";
        home = "/srv/drive";
        isSystemUser = true;
        shell = pkgs.bash;
      };
    };
  };
}
