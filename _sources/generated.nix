# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  gh-q = {
    pname = "gh-q";
    version = "a312c67b92baefadb07481ef1479c96d91243d41";
    src = fetchurl {
      url = "https://github.com/kawarimidoll/gh-q/raw/main/gh-q";
      sha256 = "sha256-mjad7EUgDC0efY+TNjTtoueO83CVkQ/sCejfD++xZYQ=";
    };
    date = "2025-03-20";
  };
  tokyo-night-yazi = {
    pname = "tokyo-night-yazi";
    version = "5f5636427f9bb16cc3f7c5e5693c60914c73f036";
    src = fetchFromGitHub {
      owner = "BennyOe";
      repo = "tokyo-night.yazi";
      rev = "5f5636427f9bb16cc3f7c5e5693c60914c73f036";
      fetchSubmodules = false;
      sha256 = "sha256-4aNPlO5aXP8c7vks6bTlLCuyUQZ4Hx3GWtGlRmbhdto=";
    };
    date = "2025-06-29";
  };
}
