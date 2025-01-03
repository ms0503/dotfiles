{ callPackage, ... }:
{
  alcom = callPackage ./alcom { };
  microsoft-edge-dev = callPackage ./microsoft-edge-dev { };
  milk-cursor-themes = callPackage ./milk-cursor-themes { };
  proton-ge-rtsp-bin = callPackage ./proton-ge-rtsp-bin { };
  unzip-unicode = callPackage ./unzip-unicode { };
  urxvt-wrapper = callPackage ./urxvt-wrapper { };
  zifu = callPackage ./zifu { };
}
