{ config, pkgs, inputs, ... }:
{
  home = {
    username = "oz";
    homeDirectory = "/home/oz";
    stateVersion = "24.11"; # Please read the comment before changing.
    packages = with pkgs; [
      _1password-cli
      _1password-gui
      apostrophe
      blesh
      codex
      devbox
      devenv
      discord
      eyedropper
      emacs
      fd
      ghc
      ghostty
      godot_4
      google-chrome
      hyfetch
      inkscape
      jdk
      jetbrains.idea-community
      scribus
      vscode-fhs
      windsurf
      zed-editor-fhs
    ];
    sessionVariables = {
      EDITOR = "code";
      TERMINAL = "bash";
    };
  };
  catppuccin.flavor = "mocha";
  nixpkgs.config.allowUnfree = true;
  programs = {
    bash = {
      enable = true;
      enableCompletion = true;
      initExtra = ''
        source "${pkgs.blesh}/share/blesh/ble.sh"
      '';
    };
    chromium = {
      enable = true;
      extensions = [
        "aeblfdkhhhdcdjpifhhbdiojplfjncoa" # 1password
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
      ];
    };
    git = {
      enable = true;
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
      };
      userName = "Oz Browning";
      userEmail = "56755170+ozmodeuz@users.noreply.github.com";
    };
    home-manager = {
      enable = true;
    };
    gnome-shell = {
      enable = true;
    };
    starship = {
      enable = true;
      enableBashIntegration = true;
      settings = {
        character = {
          success_symbol = "[](green)";
          error_symbol = "[](red)";
        };
      };
    };
    vscode = {
      enable = true;
      package = pkgs.vscode-fhs;
    };
  };
  stylix = {
    enable = true;
    autoEnable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  };
}
