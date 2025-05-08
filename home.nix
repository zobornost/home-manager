{ config, pkgs, inputs, ... }:
{
  home.username = "oz";
  home.homeDirectory = "/home/oz";
  home.stateVersion = "24.11"; # Please read the comment before changing.
  home.packages = with pkgs; [
    blesh
    emacs
    fd
    godot_4
    ghc
    haskellPackages.haskell-language-server
  ];
  home.sessionVariables = {
    EDITOR = "code";
    TERMINAL = "bash";
  };
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
    home-manager.enable = true;
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
  };
}
