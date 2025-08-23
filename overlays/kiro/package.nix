{
  lib,
  stdenv,
  fetchurl,
  makeWrapper,
  copyDesktopItems,
  makeDesktopItem,
  # Electron runtime deps (Wayland/X11/GL/audio/dbus/etc.)
  glib,
  gtk3,
  gdk-pixbuf,
  libnotify,
  libsecret,
  gsettings-desktop-schemas,
  dbus,
  cups,
  xorg,
  pango,
  cairo,
  alsa-lib,
  at-spi2-atk,
  libdrm,
  mesa,
  libxkbcommon,
  wayland,
  libGL,
  libgbm,
  nss,
  nspr,
  systemd,
  expat,
  ...
}:
let
  info =
    (lib.importJSON ./info.json)."${stdenv.hostPlatform.system}"
      or (throw "kiro: unsupported system ${stdenv.hostPlatform.system}");

  additionalElectronDeps = [
    glib
    dbus
    cups
    xorg.libX11
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXrandr
    xorg.libxcb
    pango
    cairo
    alsa-lib
    at-spi2-atk
    libdrm
    mesa
    libxkbcommon
    wayland
    libGL
    libgbm
    nss
    nspr
    systemd
    gtk3
    gdk-pixbuf
    libnotify
    libsecret
    gsettings-desktop-schemas
    expat
  ];
in
stdenv.mkDerivation rec {
  pname = "kiro";
  version = info.version;

  src = fetchurl { inherit (info) url sha256; };

  # Tarball layout: top-level "Kiro/" directory containing bin/kiro, resources, etc.
  unpackPhase = ''
    runHook preUnpack
    mkdir source
    tar -xzf "$src" -C source --strip-components=1
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p "$out"
    cp -r source/* "$out/"
    # Ensure the main CLI is on PATH and has required env at runtime.
    mkdir -p "$out/bin"
    if [ -x "$out/bin/kiro" ]; then
      target="$out/bin/kiro"
    elif [ -x "$out/kiro" ]; then
      # some Electron apps ship a top-level launcher alongside bin/
      mv "$out/kiro" "$out/bin/kiro"
      target="$out/bin/kiro"
    else
      # fallback: if there is a single executable under bin/, link it as kiro
      if [ -d "$out/bin" ]; then
        firstExe="$(find "$out/bin" -maxdepth 1 -type f -perm -111 | head -n1 || true)"
        if [ -n "$firstExe" ]; then
          ln -s "$(basename "$firstExe")" "$out/bin/kiro"
        fi
      fi
      target="$out/bin/kiro"
    fi
    # Install application icon for desktop integration
    install -Dm644 ${./kiro.png} "$out/share/icons/hicolor/512x512/apps/kiro.png"
    runHook postInstall
  '';

  nativeBuildInputs = [
    makeWrapper
    copyDesktopItems
  ];
  buildInputs = lib.optionals stdenv.hostPlatform.isLinux additionalElectronDeps;

  desktopItems = [
    (makeDesktopItem {
      name = "kiro";
      exec = "kiro";
      icon = "kiro";
      desktopName = "Kiro";
      comment = "AI Code Editor";
      categories = [
        "Development"
        "TextEditor"
      ];
      startupWMClass = "kiro-url-handler";
    })
  ];

  # Wrap the launcher to avoid setuid sandbox issues and supply needed libs.
  postFixup = lib.optionalString stdenv.hostPlatform.isLinux ''
    if [ -x "$out/bin/kiro" ]; then
      wrapProgram "$out/bin/kiro" \
        --set ELECTRON_DISABLE_SANDBOX 1 \
        --set ELECTRON_OZONE_PLATFORM_HINT auto \
        --set ELECTRON_ENABLE_WAYLAND 1 \
        --set GDK_SCALE 1 \
        --set GDK_DPI_SCALE 1 \
        --set QT_AUTO_SCREEN_SCALE_FACTOR 1 \
        --set QT_SCALE_FACTOR 1 \
        --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath additionalElectronDeps} \
        --prefix XDG_DATA_DIRS : "${gtk3}/share:${gsettings-desktop-schemas}/share:${gdk-pixbuf}/share" \
        --set GIO_EXTRA_MODULES "${glib.out}/lib/gio/modules" \
        --add-flags "--class=dev.kiro.kiro"
    fi
  '';

  meta = {
    description = "Kiro (binary distribution) – packaged for Nix/Home Manager";
    homepage = "https://example.com/kiro";
    license = lib.licenses.unfreeRedistributable // {
      shortName = "unfree-binary";
    };
    maintainers = with lib.maintainers; [ ];
    platforms = [ "x86_64-linux" ];
    sourceProvenance = [ lib.sourceTypes.binaryBytecode ];
  };
}
