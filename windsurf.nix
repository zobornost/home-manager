{ pkgs, ... }:

let
  windsurfEnv = pkgs.buildFHSEnv {
    name = "windsurf-rust";
    # Include required packages
    targetPkgs = pkgs: with pkgs; [
      bash windsurf rustup
      gcc binutils gnumake 
      pkg-config openssl.dev gtk3.dev
    ];
    
    runScript = ''
      bash -c '
        export HOME=/home/oz/.windsurf-rust
        export PATH="$PATH:${pkgs.rustup}/bin"
        exec windsurf
      '
    '';
  };
in

{
  home.packages = [ windsurfEnv ];
  
  # Add a desktop entry for easily launching Windsurf in container
  home.file.".local/share/applications/windsurf-rust.desktop".text = ''
    [Desktop Entry]
    Name=Windsurf (Rust)
    Comment=Windsurf with isolated Rust environment
    Exec=${windsurfEnv}/bin/windsurf-rust
    Terminal=false
    Type=Application
    Categories=Development;
    Icon=windsurf
    StartupWMClass=windsurf-rust
  '';
}
