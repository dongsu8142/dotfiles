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
    rev = "282a23f4469ee305e05ec7a108a728ee389d87fb";
    sha256 = "sha256-gS2wtcY6KR045F1TA1ZuDRSK2hs8tbmUUQriPtgWQiw=";
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
