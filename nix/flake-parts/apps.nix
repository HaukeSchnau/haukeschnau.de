{ ... }:
{
  perSystem =
    {
      pkgs,
      ...
    }:
    let
      updateDepsScript = pkgs.writeShellApplication {
        name = "update-deps";
        runtimeInputs = [
          pkgs.nix
          pkgs.gnused
          pkgs.perl
        ];
        text = ''
          set -euo pipefail

          usage() {
            echo "Usage: nix run .#update-deps -- site [--write]" >&2
            exit 1
          }

          if [[ $# -lt 1 ]]; then
            usage
          fi

          app_name="$1"
          shift

          if [[ "$app_name" != "site" ]]; then
            echo "Unsupported app ''${app_name}. Expected 'site'." >&2
            exit 1
          fi

          write_result=0
          if [[ "''${1:-}" == "--write" ]]; then
            write_result=1
            shift
          fi

          if [[ $# -ne 0 ]]; then
            usage
          fi

          system="$(nix eval --impure --raw --expr 'builtins.currentSystem')"

          set +e
          build_output="$(nix build .#deps-hash-site --no-link 2>&1)"
          build_status=$?
          set -e

          if [[ $build_status -eq 0 ]]; then
            echo "Expected deps-hash-site to fail because it uses fakeHash, but it succeeded." >&2
            exit 1
          fi

          hash_value="$(
            printf '%s\n' "$build_output" \
              | sed -nE 's/.*got:[[:space:]]*(sha256-[A-Za-z0-9+/=]+).*/\1/p' \
              | tail -n 1
          )"

          if [[ -z "$hash_value" ]]; then
            echo "Failed to parse hash from nix output." >&2
            printf '%s\n' "$build_output" >&2
            exit 1
          fi

          echo "site (''${system}): ''${hash_value}"

          if [[ $write_result -eq 1 ]]; then
            site_file="nix/site.nix"
            tmp_file="$(mktemp)"

            SYSTEM_NAME="$system" HASH_VALUE="$hash_value" \
              perl -0777 -pe '
                my $system = quotemeta($ENV{SYSTEM_NAME});
                my $hash = $ENV{HASH_VALUE};
                my $pattern = qr/(depsHashBySystem\s*=\s*\{.*?$system\s*=\s*")[^"]*(";\s*)/s;
                if ($_ =~ $pattern) {
                  s/$pattern/$1$hash$2/s;
                } else {
                  die "Could not update depsHashBySystem for system $ENV{SYSTEM_NAME}.\n";
                }
              ' "$site_file" > "$tmp_file"

            mv "$tmp_file" "$site_file"
            echo "Updated ''${site_file}: depsHashBySystem.''${system}"
          fi
        '';
      };
    in
    {
      packages.update-deps = updateDepsScript;

      apps.update-deps = {
        type = "app";
        program = "${updateDepsScript}/bin/update-deps";
      };
    };
}
