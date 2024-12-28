{
  adwaita-icon-theme,
  hyprcursor,
  lib,
  progressStyle ? 1,
  stdenvNoCC,
  unar,
  win2xcur,
  xcur2png
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  buildInputs = [
    adwaita-icon-theme
    hyprcursor
  ];
  buildPhase = ''
    runHook preBuild
    _src="/build/Milk Cursor"
    _build=/build/build
    mkdir build
    for i in Milk{1..4}; do
      mkdir "$_build/$i"
      cd "$_build/$i"
      win2xcur "$_src/$i/"* -o "$_src/$i"
      mkdir cursors
      cp "$_src/$i/$i テキスト選択" cursors/text
      cp "$_src/$i/$i テキスト選択" cursors/xterm
      cp "$_src/$i/$i ヘルプの選択" cursors/help
      cp "$_src/$i/$i リンクの選択" cursors/pointer
      cp "$_src/$i/$i 上下に拡大・縮小" cursors/col-resize
      cp "$_src/$i/$i 上下に拡大・縮小" cursors/n-resize
      cp "$_src/$i/$i 上下に拡大・縮小" cursors/ns-resize
      cp "$_src/$i/$i 上下に拡大・縮小" cursors/s-resize
      cp "$_src/$i/$i 利用不可" cursors/no-drop
      cp "$_src/$i/$i 利用不可" cursors/not-allowed
      cp "$_src/$i/$i 左右に拡大・縮小" cursors/e-resize
      cp "$_src/$i/$i 左右に拡大・縮小" cursors/ew-resize
      cp "$_src/$i/$i 左右に拡大・縮小" cursors/row-resize
      cp "$_src/$i/$i 左右に拡大・縮小" cursors/w-resize
      cp "$_src/$i/$i 待ち状態${builtins.toString progressStyle}" cursors/progress
      cp "$_src/$i/$i 待ち状態${builtins.toString progressStyle}" cursors/wait
      cp "$_src/$i/$i 斜めに拡大・縮小1" cursors/nw-resize
      cp "$_src/$i/$i 斜めに拡大・縮小1" cursors/nwse-resize
      cp "$_src/$i/$i 斜めに拡大・縮小1" cursors/se-resize
      cp "$_src/$i/$i 斜めに拡大・縮小2" cursors/ne-resize
      cp "$_src/$i/$i 斜めに拡大・縮小2" cursors/nesw-resize
      cp "$_src/$i/$i 斜めに拡大・縮小2" cursors/sw-resize
      cp "$_src/$i/$i 移動" cursors/all-scroll
      cp "$_src/$i/$i 通常" cursors/default
      cp "$_src/$i/$i 通常" cursors/left_ptr
      printf '[Icon Theme]\n' >index.theme
      printf 'Comment = Unofficial Milk-chan cursor theme %d\n' "''${i#Milk}" >>index.theme
      printf 'Example = default\n' >>index.theme
      printf 'Inherits = Adwaita\n' >>index.theme
      printf 'Name = %s' "$i" >>index.theme
      hyprcursor-util -x . -o "$_build"
      sed -i 's/^description = .*$/description = Unofficial Milk-chan cursor theme '"''${i#Milk}"'/' "$_build/extracted_$i/manifest.hl"
      sed -i 's/^name = .*$/name = '"$i"'/' "$_build/extracted_$i/manifest.hl"
      sed -i 's/^version = .*$/version = ${finalAttrs.version}/' "$_build/extracted_$i/manifest.hl"
      hyprcursor-util -c "$_build/extracted_$i" -o "$_build"
    done
    runHook postBuild
  '';
  installPhase = ''
    runHook preInstall
    _build=/build/build
    for i in Milk{1..4}; do
      install -dm755 "$out/share/icons/$i/cursors"
      install -dm755 "$out/share/icons/$i/hyprcursors"
      install -Dm444 "$_build/$i/index.theme" "$out/share/icons/$i/index.theme"
      install -Dm444 "$_build/theme_$i/manifest.hl" "$out/share/icons/$i/manifest.hl"
      install -Dm444 -t "$out/share/icons/$i/cursors" "$_build/$i/cursors/"*
      install -Dm444 -t "$out/share/icons/$i/hyprcursors" "$_build/theme_$i/hyprcursors/"*
    done
    runHook postInstall
  '';
  meta = {
    changelog = "https://466.booth.pm/items/4046750";
    description = "Unofficial Milk-chan cursor themes";
    downloadPage = "https://466.booth.pm/items/4046750";
    homepage = "https://466.booth.pm/items/4046750";
    license = lib.licenses.unfree;
    platforms = lib.platforms.all;
    sourceProvenance = with lib.sourceTypes; [
      fromSource
    ];
  };
  nativeBuildInputs = [
    hyprcursor
    unar
    win2xcur
    xcur2png
  ];
  patchPhase = ''
    runHook prePatch
    cd "/build/Milk Cursor 追加用"
    for file in *; do
      mv "$file" "''${file^}"
    done
    cd /build
    for i in Milk{1..4}; do
      mv "Milk Cursor 追加用/$i"* "Milk Cursor/$i"
      mv "Milk Cursor/$i/$i 待ち状態"{,1}.ani
    done
    runHook postPatch
  '';
  phases = [
    "unpackPhase"
    "patchPhase"
    "buildPhase"
    "installPhase"
  ];
  pname = "milk-cursor-themes";
  sourceRoot = ".";
  src = lib.fileset.toSource {
    fileset = ../../externals/milk-cursor-themes;
    root = ../../externals/milk-cursor-themes;
  };
  unpackPhase = ''
    runHook preUnpack
    unar "$src/Milk_Cursor.zip"
    unar "$src/Milk_Cursor_追加用.zip"
    runHook postUnpack
  '';
  version = "1.0.1";
})
# vim: et sts=2 sw=2 ts=2
