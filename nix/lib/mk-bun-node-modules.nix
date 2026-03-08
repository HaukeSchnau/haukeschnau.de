{
  pkgs,
  lib,
  src,
  site,
  outputHash,
}:
pkgs.stdenvNoCC.mkDerivation {
  pname = "${site.name}-node-modules";
  version = "0.1.0";
  inherit src;

  impureEnvVars = lib.fetchers.proxyImpureEnvVars ++ [
    "GIT_PROXY_COMMAND"
    "SOCKS_SERVER"
  ];

  nativeBuildInputs = [
    pkgs.bun
    pkgs.writableTmpDirAsHomeHook
  ];

  dontConfigure = true;
  dontFixup = true;

  buildPhase = ''
    runHook preBuild

    export BUN_INSTALL_CACHE_DIR="$(mktemp -d)"

    bun install \
      --frozen-lockfile \
      --ignore-scripts \
      --no-progress \
      --linker=hoisted \
      --filter ${lib.escapeShellArg site.packageName}

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p "$out"
    find . -type d -name node_modules -exec cp -R --parents "{}" "$out" \;

    runHook postInstall
  '';

  inherit outputHash;
  outputHashAlgo = "sha256";
  outputHashMode = "recursive";
}
