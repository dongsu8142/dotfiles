{ lib, stdenv, pkgs, ...}:

let
  version = "3.21.192.18";
  deps = with pkgs; [
    alsa-lib at-spi2-atk at-spi2-core atk cairo cups dbus expat
    fontconfig freetype gdk-pixbuf glib gtk3 libdrm xorg.libX11 libGL
    libxkbcommon xorg.libXScrnSaver xorg.libXcomposite xorg.libXcursor xorg.libXdamage
    xorg.libXext xorg.libXfixes xorg.libXi xorg.libXrandr xorg.libXrender xorg.libxshmfence
    xorg.libXtst libuuid mesa nspr nss pango pipewire udev wayland
    xorg.libxcb zlib snappy libkrb5 libpulseaudio libva
  ];
  rpath = lib.makeLibraryPath deps + ":" + lib.makeSearchPathOutput "lib" "lib64" deps;
  binpath = lib.makeBinPath deps;
  enableFeatures = lib.optionals stdenv.isLinux [ "VaapiVideoDecoder" "VaapiVideoEncoder" ];
  disableFeatures = lib.optional stdenv.isLinux "UseChromeOSDirectVideoDecoder";
in
stdenv.mkDerivation {
  pname = "naver-whale";
  inherit version;

  src = pkgs.fetchurl {
    url = "https://repo.whale.naver.com/stable/deb/pool/main/n/naver-whale-stable/naver-whale-stable_${version}-1_amd64.deb";
    sha256 = "sha256-cPmfR8JwLpnk63hgAo/N/pqpE3e47tXBQYT5gllApkk=";
  };

  dontConfigure = true;
  dontBuild = true;
  dontPatchELF = true;
  doInstallCheck = true;

  nativeBuildInputs = with pkgs; [
    dpkg
    wrapGAppsHook
  ];

  buildInputs = with pkgs; [
    glib gsettings-desktop-schemas gtk3
    gnome.adwaita-icon-theme
  ];

  unpackPhase = "dpkg-deb --fsys-tarfile $src | tar -x --no-same-permissions --no-same-owner";

  installPhase = ''
    runHook preInstall
    mkdir -p $out $out/bin
    cp -R usr/share $out
    cp -R opt/ $out/opt
    echo ${rpath}

    export BINARYWRAPPER=$out/opt/naver/whale/naver-whale

    substituteInPlace $BINARYWRAPPER \
          --replace /bin/bash ${stdenv.shell}

    ln -sf $BINARYWRAPPER $out/bin/naver-whale

    for exe in $out/opt/naver/whale/{whale,chrome_crashpad_handler}; do
      patchelf \
        --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
        --set-rpath "${rpath}" $exe
    done

    substituteInPlace $out/share/applications/naver-whale.desktop \
          --replace /usr/bin/naver-whale $out/bin/naver-whale
      substituteInPlace $out/share/gnome-control-center/default-apps/naver-whale.xml \
          --replace /opt/naver $out/opt/naver
      substituteInPlace $out/share/menu/naver-whale.menu \
          --replace /opt/naver $out/opt/naver
      substituteInPlace $out/opt/naver/whale/default-app-block \
          --replace /opt/naver $out/opt/naver

    icon_sizes=("16" "24" "32" "48" "64" "128" "256")

    for icon in ''${icon_sizes[*]}
    do
      mkdir -p $out/share/icons/hicolor/$icon\x$icon/apps
      ln -s $out/opt/naver/whale/product_logo_$icon.png $out/share/icons/hicolor/$icon\x$icon/apps/naver-whale.png
    done
    ln -sf ${pkgs.xdg-utils}/bin/xdg-settings $out/opt/naver/whale/xdg-settings
    ln -sf ${pkgs.xdg-utils}/bin/xdg-mime $out/opt/naver/whale/xdg-mime

    runHook postInstall
  '';

  preFixup = ''
    # Add command line args to wrapGApp.
    gappsWrapperArgs+=(
      --prefix LD_LIBRARY_PATH : ${rpath}
      --prefix PATH : ${binpath}
      --suffix PATH : ${lib.makeBinPath [ pkgs.xdg-utils ]}
      ${lib.optionalString (enableFeatures != []) ''
      --add-flags "--enable-features=${lib.strings.concatStringsSep "," enableFeatures}"
      ''}
      ${lib.optionalString (disableFeatures != []) ''
      --add-flags "--disable-features=${lib.strings.concatStringsSep "," disableFeatures}"
      ''}
      --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations}}"
    )
  '';

  installCheckPhase = ''
    # Bypass upstream wrapper which suppresses errors
    $out/opt/naver/whale/naver-whale --version
  '';

  meta = with lib; {
    description = "naver-whale";
    homepage = "https://whale.naver.com";
    platforms = [ "x86_64-linux" "x86_64-drawn" ];
    maintainers = [ maintainers.rayandrew ];
    license = licenses.gpl3;
  };
}
