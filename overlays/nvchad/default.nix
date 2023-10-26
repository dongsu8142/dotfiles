{ lib, stdenv, pkgs }:

let
  custom = ./custom;
in
stdenv.mkDerivation {
  pname = "nvchad";
  version = "2.0.0";

  src = pkgs.fetchFromGitHub {
    owner = "NvChad";
    repo = "NvChad";
    rev = "fd10af115e0507b3976d78123eda9748fe0e2d29";
    sha256 = "sha256-7GfprTjfCrXzFiZOVw/tCB9bhA9sbNY7AicmbLXzICs=";
  };

  installPhase = ''
    mkdir $out
    cp -r * "$out/"
    mkdir -p "$out/lua/custom"
    cp -r ${custom}/* "$out/lua/custom/"
  '';

  meta = with lib; {
    description = "NvChad";
    homepage = "https://github.com/NvChad/NvChad";
    platforms = platforms.all;
    maintainers = [ maintainers.rayandrew ];
    license = licenses.gpl3;
  };
}
