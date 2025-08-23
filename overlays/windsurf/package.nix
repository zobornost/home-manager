{
  lib,
  stdenv,
  callPackage,
  vscode-generic,
  fetchurl,
  nixosTests,
  commandLineArgs ? "",
  useVSCodeRipgrep ? stdenv.hostPlatform.isDarwin,
  makeWrapper,
  copyDesktopItems,
  makeDesktopItem,
  # Additional dependencies for Playwright/browser functionality
  expat,
  libdrm,
  mesa,
  libxkbcommon,
  wayland,
  libGL,
  glib,
  dbus,
  cups,
  xorg,
  pango,
  cairo,
  alsa-lib,
  at-spi2-atk,
  libgbm,
  nss,
  nspr,
  systemd,
}:
let
  info =
    (lib.importJSON ./info.json)."${stdenv.hostPlatform.system}"
      or (throw "windsurf: unsupported system ${stdenv.hostPlatform.system}");

  # Additional Playwright runtime dependencies
  additionalPlaywrightDeps = [
    glib # libglib-2.0.so.0, libgobject-2.0.so.0, libgio-2.0.so.0
    dbus # libdbus-1.so.3
    cups # libcups.so.2
    xorg.libX11 # libX11.so.6
    xorg.libXcomposite # libXcomposite.so.1
    xorg.libXdamage # libXdamage.so.1
    xorg.libXext # libXext.so.6
    xorg.libXfixes # libXfixes.so.3
    xorg.libXrandr # libXrandr.so.2
    xorg.libxcb # libxcb.so.1
    pango # libpango-1.0.so.0
    cairo # libcairo.so.2
    expat # libexpat.so.1
    libdrm # Additional graphics support
    mesa # Additional graphics support
    libxkbcommon # Keyboard support
    wayland # Wayland support
    libGL # OpenGL support
    # Re-adding vscode-generic deps that Playwright needs at runtime
    alsa-lib # libasound.so.2
    at-spi2-atk # libatk-1.0.so.0, libatk-bridge-2.0.so.0, libatspi.so.0
    libgbm # libgbm.so.1
    nss # libnss3.so, libnssutil3.so, libsmime3.so
    nspr # libnspr4.so
    systemd # libudev.so.1
  ];
in
(callPackage vscode-generic {
  inherit commandLineArgs useVSCodeRipgrep;

  inherit (info) version vscodeVersion;
  pname = "windsurf";

  executableName = "windsurf";
  longName = "Windsurf";
  shortName = "windsurf";
  libraryName = "windsurf";
  iconName = "windsurf";

  sourceRoot = if stdenv.hostPlatform.isDarwin then "Windsurf.app" else "Windsurf";

  src = fetchurl { inherit (info) url sha256; };

  tests = nixosTests.vscodium;

  updateScript = ./update/update.mts;

  # Editing the `codium` binary (and shell scripts) within the app bundle causes the bundle's signature
  # to be invalidated, which prevents launching starting with macOS Ventura, because VSCodium is notarized.
  # See https://eclecticlight.co/2022/06/17/app-security-changes-coming-in-ventura/ for more information.
  dontFixup = stdenv.hostPlatform.isDarwin;

  meta = {
    description = "Agentic IDE powered by AI Flow paradigm";
    longDescription = ''
      The first agentic IDE, and then some.
      The Windsurf Editor is where the work of developers and AI truly flow together, allowing for a coding experience that feels like literal magic.
    '';
    homepage = "https://codeium.com/windsurf";
    license = lib.licenses.unfree;
    maintainers = with lib.maintainers; [
      sarahec
      xiaoxiangmoe
    ];
    platforms = [
      "aarch64-darwin"
      "x86_64-darwin"
      "x86_64-linux"
    ];
    sourceProvenance = [ lib.sourceTypes.binaryBytecode ];
  };
}).overrideAttrs
  (oldAttrs: {
    # Add additional dependencies for Playwright/browser functionality
    buildInputs =
      (oldAttrs.buildInputs or [ ]) ++ lib.optionals stdenv.hostPlatform.isLinux additionalPlaywrightDeps;

    # Add runtime dependencies for Playwright
    runtimeDependencies =
      (oldAttrs.runtimeDependencies or [ ])
      ++ lib.optionals stdenv.hostPlatform.isLinux additionalPlaywrightDeps;

    # Fix chrome-sandbox permissions by setting ELECTRON_DISABLE_SANDBOX
    nativeBuildInputs =
      (oldAttrs.nativeBuildInputs or [ ])
      ++ lib.optionals stdenv.hostPlatform.isLinux [
        makeWrapper
        copyDesktopItems
      ];

    desktopItems = [
      (makeDesktopItem {
        name = "windsurf";
        exec = "windsurf";
        icon = "windsurf";
        desktopName = "Windsurf";
        comment = "AI Code Editor";
        categories = [
          "Development"
          "TextEditor"
        ];
        startupWMClass = "windsurf";
      })
    ];

    # Install application icon for desktop integration
    postInstall =
      (oldAttrs.postInstall or "")
      + lib.optionalString stdenv.hostPlatform.isLinux ''
        install -Dm644 ${./windsurf.png} "$out/share/icons/hicolor/512x512/apps/windsurf.png"
      '';

    # Wrap the binary to set ELECTRON_DISABLE_SANDBOX environment variable
    # This disables the chrome sandbox without needing setuid permissions
    postFixup =
      (oldAttrs.postFixup or "")
      + lib.optionalString stdenv.hostPlatform.isLinux ''
        wrapProgram "$out/bin/windsurf" \
          --set ELECTRON_DISABLE_SANDBOX 1\
          --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath additionalPlaywrightDeps}
      '';
  })
