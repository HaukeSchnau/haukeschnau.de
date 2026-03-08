{
  name = "site";
  packageName = "haukeschnau.de";
  path = ".";
  buildScript = "build";
  artifactPath = "./dist";

  depsHashBySystem = {
    aarch64-darwin = "sha256-+Uh97DXDdyTCb3JXx4P/o3S+f0C8CLmmABQF1Hzvd5k=";
    x86_64-darwin = "sha256-cM9gwaRC9kiiA5NmTvll7V3GmdYTyT+hkC6It+DVm14=";
    aarch64-linux = "sha256-I+vuiVbpjUQrzr0R/Fz03G4MNDR9lw+Bpzbw+//EH1E=";
  };

  image = {
    source = "https://github.com/schnau-dev/haukeschnau.de";
    description = "Static site image for haukeschnau.de.";
    tag = "latest";
    port = 80;
  };
}
