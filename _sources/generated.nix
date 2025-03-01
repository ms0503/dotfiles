# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  gh-q = {
    pname = "gh-q";
    version = "5dc627f350902e0166016a9dd1f9479c75e3f392";
    src = fetchurl {
      url = "https://github.com/kawarimidoll/gh-q/raw/main/gh-q";
      sha256 = "sha256-i6EYYRrzC+9LzsGsA0fekMQIZAth1oEWd1L8+tkbmTA=";
    };
    date = "2021-11-20";
  };
  tokyo-night-yazi = {
    pname = "tokyo-night-yazi";
    version = "9e6f8997c7419bddbf341c1ad5e4bf0a0aa43824";
    src = fetchFromGitHub {
      owner = "BennyOe";
      repo = "tokyo-night.yazi";
      rev = "9e6f8997c7419bddbf341c1ad5e4bf0a0aa43824";
      fetchSubmodules = false;
      sha256 = "sha256-E6KEiH7B65oxmRLLG5/vedQK2GbzljXsvYL7XlAT5+Y=";
    };
    date = "2025-01-24";
  };
}
