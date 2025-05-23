{ pkgs, ... }:

let
  windsurfRustEnv = pkgs.buildFHSEnv {
    name = "windsurf-rust";
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
        openssl.dev
        pango.dev
        pkg-config
        rustc
        rustfmt
        rustPlatform.rustLibSrc
        vulkan-headers
        vulkan-loader.dev
        vulkan-tools
        windsurf
      ];

    runScript = ''
      bash -c '
        export RUST_SRC_PATH=${pkgs.rustPlatform.rustLibSrc}
        export HOME=/home/oz/.windsurf-rust
        exec windsurf
      '
    '';
  };
  windsurfValaEnv = pkgs.buildFHSEnv {
    name = "windsurf-vala";
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
        meson
        ninja
        pango.dev
        pkg-config
        python3
        vala
        vulkan-headers
        vulkan-loader.dev
        vulkan-tools
        windsurf
      ];
    runScript = ''
      bash -c '
        export HOME=/home/oz/.windsurf-vala
        exec windsurf
      '
    '';
  };
in
{
  home.packages = [
    windsurfRustEnv
    windsurfValaEnv
  ];

  # Add a desktop entry for easily launching Windsurf in container
  home.file.".local/share/applications/windsurf-rust.desktop".text = ''
    [Desktop Entry]
    Name=Windsurf (Rust)
    Comment=Windsurf with isolated Rust environment
    Exec=${windsurfRustEnv}/bin/windsurf-rust
    Terminal=false
    Type=Application
    Categories=Development;
    Icon=windsurf
    StartupWMClass=windsurf-rust
  '';

  home.file.".local/share/applications/windsurf-vala.desktop".text = ''
    [Desktop Entry]
    Name=Windsurf (Vala)
    Comment=Windsurf with isolated Vala environment
    Exec=${windsurfValaEnv}/bin/windsurf-vala
    Terminal=false
    Type=Application
    Categories=Development;
    Icon=windsurf
    StartupWMClass=windsurf-vala
  '';
}
