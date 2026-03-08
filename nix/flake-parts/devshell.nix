{ ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      devShells.default = pkgs.mkShellNoCC {
        packages = with pkgs; [
          bun
          caddy
          just
        ];
      };
    };
}
