{ config, pkgs, ... }:

{
  home.username = "oz";
  home.homeDirectory = "/home/oz";
  home.stateVersion = "24.11"; # Please read the comment before changing.
  home.packages = [
  ];
  home.sessionVariables = {
    EDITOR = "code";
    TERMINAL = "nu";
  };
  programs = {
    bash.enable = true;
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
    nushell = {
      enable = true;
      configFile.text = ''
        $env.config.show_banner = false
        use ~/.cache/starship/init.nu
      '';
      envFile.text = ''
        mkdir ~/.cache/starship
        starship init nu | save -f ~/.cache/starship/init.nu
      '';
    };
    starship = {
      enable = true;
      enableBashIntegration = true;
      enableNushellIntegration = true;
      settings = {
        character = {
          success_symbol = "[](green)";
          error_symbol = "[](red)";
        };
      };
    };
  };
}
