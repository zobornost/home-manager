{
  lib,
  stdenv,
  fetchurl,
  copyDesktopItems,
  makeDesktopItem,
  # JetBrains IDE runtime deps
  jdk17,
  fontconfig,
  freetype,
  libX11,
  libXext,
  libXi,
  libXrender,
  libXtst,
  libxcb,
  xorg,
  glib,
  gtk3,
  pango,
  cairo,
  gdk-pixbuf,
  atk,
  zlib,
  ...
}:
let
  info =
    (lib.importJSON ./info.json)."${stdenv.hostPlatform.system}"
      or (throw "rustrover: unsupported system ${stdenv.hostPlatform.system}");

  # Dependencies needed for JetBrains IDEs
  runtimeDeps = [
    fontconfig
    freetype
    libX11
    libXext
    libXi
    libXrender
    libXtst
    libxcb
    xorg.libXxf86vm
    glib
    gtk3
    pango
    cairo
    gdk-pixbuf
    atk
    zlib
  ];
in
stdenv.mkDerivation rec {
  pname = "rustrover";
  version = info.version;

  src = fetchurl { inherit (info) url sha256; };

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
    
    # Ensure the rustrover binary is executable
    chmod +x "$out/bin/rustrover"
    
    runHook postInstall
  '';

  nativeBuildInputs = [
    copyDesktopItems
  ];
  
  buildInputs = lib.optionals stdenv.hostPlatform.isLinux runtimeDeps;

  desktopItems = [
    (makeDesktopItem {
      name = "rustrover";
      exec = "rustrover";
      icon = "rustrover";
      desktopName = "RustRover";
      comment = "Rust IDE by JetBrains";
      categories = [
        "Development"
        "IDE"
      ];
      startupWMClass = "jetbrains-rustrover";
    })
  ];

  postFixup = lib.optionalString stdenv.hostPlatform.isLinux ''
    if [ -x "$out/bin/rustrover" ]; then
      mv "$out/bin/rustrover" "$out/bin/.rustrover-unwrapped"
      cat > "$out/bin/rustrover" << 'EOF'
#!/bin/bash
export JAVA_HOME="${jdk17}"
export LD_LIBRARY_PATH="${lib.makeLibraryPath runtimeDeps}:$LD_LIBRARY_PATH"
export PATH="${jdk17}/bin:$PATH"
export _JAVA_AWT_WM_NONREPARENTING=1
exec "$(dirname "$0")/.rustrover-unwrapped" "$@"
EOF
      chmod +x "$out/bin/rustrover"
    fi
  '';

  meta = {
    description = "RustRover IDE by JetBrains – packaged for Nix/Home Manager";
    homepage = "https://www.jetbrains.com/rust/";
    license = lib.licenses.unfree;
    maintainers = with lib.maintainers; [ ];
    platforms = [ "x86_64-linux" ];
    sourceProvenance = [ lib.sourceTypes.binaryBytecode ];
  };
}