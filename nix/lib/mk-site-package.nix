{
  pkgs,
  lib,
  src,
  site,
  nodeModules,
}:
pkgs.stdenvNoCC.mkDerivation {
  pname = site.name;
  version = "0.1.0";
  inherit src;

  nativeBuildInputs = [
    pkgs.bun
    pkgs.writableTmpDirAsHomeHook
  ];

  configurePhase = ''
    runHook preConfigure

    cp -R ${nodeModules}/. .
    chmod -R u+w node_modules

    runHook postConfigure
  '';

  buildPhase = ''
    runHook preBuild

    (
      cd ${site.path}
      export ASTRO_TELEMETRY_DISABLED=1
      bun run ${lib.escapeShellArg site.buildScript}
    )

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p "$out"
    cp -R ${site.artifactPath}/. "$out"/

    runHook postInstall
  '';
}
