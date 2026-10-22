
{
  lib,
  stdenvNoCC,
  fetchurl,
  writeShellScriptBin,
}:

let
  nodeVersion = "22.23.3";
  nodeVariant = "darwin-arm64";

  node = stdenvNoCC.mkDerivation {
    pname = "nodejs-dsh";
    version = nodeVersion;

    src = fetchurl {
      url = "https://nodejs.org/dist/v${nodeVersion}/node-v${nodeVersion}-${nodeVariant}.tar.gz";
      hash = "sha256-I7JSRdz7mvcmL4/xQuni4K8CU2gRcynnp0WKUeWSL1M=";
    };

    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      runHook preInstall
      mkdir -p "$out"
      cp -a . "$out"/
      runHook postInstall
    '';

    meta = {
      description = "Official Node.js ${nodeVersion} runtime for dsh";
      platforms = [ "aarch64-darwin" ];
    };
  };
in
(writeShellScriptBin "dsh" ''
  export PATH="${node}/bin:$PATH"

  exec "${node}/bin/node" \
    "${node}/lib/node_modules/npm/bin/npx-cli.js" \
    -y @deepseek-ai/dsh "$@"
'').overrideAttrs (old: {
  meta = (old.meta or { }) // {
    description = "DeepSeek Harness with official Node.js";
    homepage = "https://github.com/deepseek-ai/deepseek-harness";
    license = lib.licenses.mit;
    mainProgram = "dsh";
    platforms = [ "aarch64-darwin" ];
  };
})
