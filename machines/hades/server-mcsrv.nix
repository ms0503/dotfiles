{
  services.nginx.virtualHosts."mcsrv.ms0503.dev" = {
    locations = {
      "/" = {
        root = "/data/www/mcsrv";
      };
      "/maps/create-aeronautics".return = "301 /maps/create-aeronautics/";
      "/maps/create-aeronautics/" = {
        alias = "/data/mcsrv/bluemap/create-aeronautics/web/";
        extraConfig = ''
          gzip_static always;
        '';
      };
      "@empty".return = "204";
      "~* ^/maps/create-aeronautics/(maps/[^\\s/]*/live/[^\\s]*)$".proxyPass = "http://127.0.0.1:8100/$1";
      "~* ^/maps/create-aeronautics/(maps/[^\\s/]*/tiles/[^\\s]*)$" = {
        alias = "/data/mcsrv/bluemap/create-aeronautics/web/$1";
        extraConfig = ''
          error_page 404 = @empty;
          gzip_static always;
        '';
      };
    };
    reuseport = true;
  };
  users.users.nginx.extraGroups = [
    "minecraft"
  ];
}
