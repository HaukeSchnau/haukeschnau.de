{ ... }:
{
  perSystem =
    {
      pkgs,
      lib,
      system,
      ...
    }:
    let
      site = import ../site.nix;
      src = pkgs.nix-gitignore.gitignoreSource [ "result" "result-*" ] ../../.;

      mkBunNodeModules = import ../lib/mk-bun-node-modules.nix;
      mkSitePackage = import ../lib/mk-site-package.nix;

      depsPackage = mkBunNodeModules {
        inherit pkgs lib src;
        inherit site;
        outputHash = site.depsHashBySystem.${system} or lib.fakeHash;
      };

      depsHashPackage = mkBunNodeModules {
        inherit pkgs lib src;
        inherit site;
        outputHash = lib.fakeHash;
      };

      sitePackage = mkSitePackage {
        inherit pkgs lib src site;
        nodeModules = depsPackage;
      };
    in
    {
      packages = {
        default = sitePackage;
        site = sitePackage;
        deps-site = depsPackage;
        deps-hash-site = depsHashPackage;
      };
    };
}
