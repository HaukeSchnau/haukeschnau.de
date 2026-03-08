{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "aarch64-darwin"
        "x86_64-darwin"
        "aarch64-linux"
      ];

      imports = [
        ./nix/flake-parts/devshell.nix
        ./nix/flake-parts/packages.nix
        ./nix/flake-parts/images.nix
        ./nix/flake-parts/apps.nix
      ];
    };
}
