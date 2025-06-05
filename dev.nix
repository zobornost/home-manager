{ pkgs, ... }:

let
  flutterDevEnv = pkgs.buildFHSEnv {
    name = "flutter-dev";
    targetPkgs =
      pkgs: with pkgs; [
        flutter
        dart
        clang
        cmake
        ninja
        pkg-config
        gtk3
        xorg.libX11
        xorg.libxcb
        libGL
        libpulseaudio
        gst_all_1.gstreamer
        fontconfig
        freetype
        zip
        unzip
        wayland
        wayland.dev
        wayland-protocols
        wayland-utils
        xz
      ];
    runScript = ''
      bash -lc '
        export HOME=/home/oz/.flutter-dev
        exec bash
      '
    '';
  };
  rustDevEnv = pkgs.buildFHSEnv {
    name = "rust-dev";
    targetPkgs =
      pkgs: with pkgs; [
        atk.dev
        bash
        binutils
        cairo.dev
        cargo
        gdk-pixbuf.dev
        gcc
        gnumake
        harfbuzz.dev
        glib.dev
        gobject-introspection.dev
        graphene.dev
        gtk3.dev
        gtk4.dev
        libadwaita.dev
        librsvg.dev
        libsoup_3.dev
        nodejs.dev
        openssl.dev
        pango.dev
        pkg-config
        pnpm
        rustc
        rustfmt
        rustPlatform.rustLibSrc
        vulkan-headers
        vulkan-loader.dev
        vulkan-tools
        webkitgtk_4_1.dev
        windsurf
        zlib
        zlib.dev
      ];

    runScript = ''
      bash -c '
        export RUST_SRC_PATH=${pkgs.rustPlatform.rustLibSrc}
        export HOME=/home/oz/.windsurf-rust
        export PATH="$PWD/node_modules/.bin:$PATH"
        exec bash
      '
    '';
  };
  valaDevEnv = pkgs.buildFHSEnv {
    name = "vala-dev";
    targetPkgs =
      pkgs: with pkgs; [
        atk.dev
        bash
        binutils
        cairo.dev
        fontconfig.dev
        freetype.dev
        gdk-pixbuf.dev
        gcc
        glib.dev
        gtk4.dev
        gobject-introspection.dev
        graphene.dev
        gtk3.dev
        harfbuzz.dev
        libadwaita.dev
        lldb.dev
        meson
        ninja
        pango.dev
        pkg-config
        python3
        vala
        vala-language-server
        vulkan-headers
        vulkan-loader.dev
        vulkan-tools
        windsurf
      ];
    runScript = ''
      bash -c '
        export HOME=/home/oz/.windsurf-vala
        exec bash
      '
    '';
  };
in
{
  home.packages = [
    flutterDevEnv
    rustDevEnv
    valaDevEnv
  ];

  # Add a desktop entry for easily launching Windsurf in container
  home.file.".local/share/applications/rust-dev.desktop".text = ''
    [Desktop Entry]
    Name=Rust Dev
    Comment=Rust development environment
    Exec=ghostty -e ${rustDevEnv}/bin/rust-dev
    Terminal=false
    Type=Application
    Categories=Development;
    Icon=console
    StartupWMClass=rust-dev
  '';

  home.file.".local/share/applications/vala-dev.desktop".text = ''
    [Desktop Entry]
    Name=Vala Dev
    Comment=Vala development environment
    Exec=ghostty -e ${valaDevEnv}/bin/vala-dev
    Terminal=false
    Type=Application
    Categories=Development;
    Icon=console
    StartupWMClass=vala-dev
  '';

  home.file.".local/share/applications/flutter-dev.desktop".text = ''
    [Desktop Entry]
    Name=Flutter Dev
    Comment=Flutter development environment
    Exec=ghostty -e ${flutterDevEnv}/bin/flutter-dev
    Terminal=false
    Type=Application
    Categories=Development;
    Icon=console
    StartupWMClass=flutter-dev
  '';
}
