{ ... }:
{
  perSystem =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
      site = import ../site.nix;
      mkLayeredImage = import ../lib/mk-layered-image.nix;
    in
    {
      packages = lib.optionalAttrs pkgs.stdenv.isLinux {
        image-site = mkLayeredImage {
          inherit pkgs lib;
          inherit site;
          sitePackage = config.packages.site;
        };
      };
    };
}
