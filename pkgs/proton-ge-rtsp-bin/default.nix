{
  fetchzip,
  lib,
  stdenvNoCC,
  writeScript,
}:
let
  sha256 = "iq7oiDW5+51wzqYwASOGSV922c/pg1k29MdkIXlT34k=";
  version = "GE-Proton9-20-rtsp16";
in
stdenvNoCC.mkDerivation (finalAttrs: {
  inherit version;
  buildCommand = ''
    runHook preBuild

    # Make it impossible to add to an environment. You should use the appropriate NixOS option.
    # Also leave some breadcrumbs in the file.
    echo "${finalAttrs.pname} should not be installed into environments. Please use programs.steam.extraCompatPackages instead." > $out

    mkdir $steamcompattool
    ln -s $src/* $steamcompattool
    rm $steamcompattool/{compatibilitytool.vdf,proton,version}
    cp $src/{compatibilitytool.vdf,proton,version} $steamcompattool

    sed -i -r 's|GE-Proton[0-9]*-[0-9]*-rtsp[0-9]*|GE-Proton-rtsp|' $steamcompattool/compatibilitytool.vdf
    sed -i -r 's|GE-Proton[0-9]*-[0-9]*-rtsp[0-9]*|GE-Proton-rtsp|' $steamcompattool/proton

    runHook postBuild
  '';
  meta = {
    description = ''
      Compatibility tool for Steam Play based on Wine and additional components.

      (This is intended for use in the `programs.steam.extraCompatPackages` option only.)
    '';
    homepage = "https://github.com/SpookySkeletons/proton-ge-rtsp";
    license = lib.licenses.bsd3;
    platforms = [
      "x86_64-linux"
    ];
    sourceProvenance = with lib.sourceTypes; [
      binaryNativeCode
    ];
  };
  outputs = [
    "out"
    "steamcompattool"
  ];
  passthru.updateScript = writeScript "update-proton-ge-rtsp" ''
    #!/usr/bin/env nix-shell
    #!nix-shell -i bash -p common-updater-scripts curl jq
    repo=https://api.github.com/repos/SpookySkeletons/proton-ge-rtsp/releases
    version="$(curl -fsL "$repo" | jq 'map(select(.prerelease == false)) | .[0].tag_name' --raw-output)"
    update-source-version proton-ge-rtsp-bin "$version"
  '';
  pname = "proton-ge-rtsp-bin";
  src = fetchzip {
    inherit sha256;
    url = "https://github.com/SpookySkeletons/proton-ge-rtsp/releases/download/${finalAttrs.version}/${finalAttrs.version}.tar.gz";
  };
})
