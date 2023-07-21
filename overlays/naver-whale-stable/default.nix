{ lib, stdenv, pkgs }:

let
  version = "3.21.192.18";
in
stdenv.mkDerivation {
  pname = "naver-whale-stable";
  inherit version;

  src = pkgs.fetchurl {
    url = "https://repo.whale.naver.com/stable/deb/pool/main/n/naver-whale-stable/naver-whale-stable_${version}-1_amd64.deb";
    sha256 = "sha256-cPmfR8JwLpnk63hgAo/N/pqpE3e47tXBQYT5gllApkk=";
  };

  unpackPhase = ''
    runHook preUnpack
    dpkg --fsys-tarfile $src | tar --extract
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out
    cp -a opt/naver/whale/* $out
    mkdir $out/bin
    ln -s $out/naver-whale $out/bin/naver-whale-stable
    cp -a usr/share $out/share
    rm -r $out/cron/ $out/share/menu
    runHook postInstall
  '';

  dontWrapQtApps = true;

  nativeBuildInputs = with pkgs; [
    autoPatchelfHook
    dpkg
    qt5.wrapQtAppsHook
    wrapGAppsHook
  ];

  buildInputs = with pkgs; [
    alsa-lib
    nss
    gtk3
    mesa
    libsForQt5.qt5.qtbase
  ];

  meta = with lib; {
    description = "naver-whale-stable";
    homepage = "https://whale.naver.com";
    platforms = [ "x86_64-linux" "x86_64-drawn" ];
    maintainers = [ maintainers.rayandrew ];
    license = licenses.gpl3;
  };
}
