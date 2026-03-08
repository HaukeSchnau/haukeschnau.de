{
  pkgs,
  lib,
  site,
  sitePackage,
}:
let
  caddyfile = pkgs.writeTextDir "etc/caddy/Caddyfile" ''
    {
      admin off
    }

    :${toString site.image.port} {
      root * ${sitePackage}
      encode zstd gzip

      @hashed path /_astro/*
      header @hashed Cache-Control "public, max-age=31536000, immutable"

      @mutable not path /_astro/*
      header @mutable Cache-Control "public, max-age=0, must-revalidate"

      file_server
    }
  '';

  imageLabels =
    lib.optionalAttrs (site.image ? source) {
      "org.opencontainers.image.source" = site.image.source;
    }
    // lib.optionalAttrs (site.image ? description) {
      "org.opencontainers.image.description" = site.image.description;
    };
in
pkgs.dockerTools.buildLayeredImage {
  name = "haukeschnau.de";
  tag = site.image.tag or "latest";
  contents = [
    pkgs.caddy
    pkgs.cacert
    caddyfile
    sitePackage
  ];
  config =
    {
      Entrypoint = [
        "${pkgs.caddy}/bin/caddy"
        "run"
        "--config"
        "/etc/caddy/Caddyfile"
        "--adapter"
        "caddyfile"
      ];
      ExposedPorts = {
        "${toString site.image.port}/tcp" = { };
      };
      Env = [
        "SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
      ];
    }
    // lib.optionalAttrs (imageLabels != { }) {
      Labels = imageLabels;
    };
}
