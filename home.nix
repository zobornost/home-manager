{ config, pkgs, ... }:

{
  home.username = "oz";
  home.homeDirectory = "/home/oz";
  home.stateVersion = "24.11"; # Please read the comment before changing.
  home.packages = [
    pkgs.godot_4
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
        $env.config = {
          hooks: {
            pre_prompt: [{ ||
              if (which direnv | is-empty) {
                return
              }

              direnv export json | from json | default {} | load-env
              if 'ENV_CONVERSIONS' in $env and 'PATH' in $env.ENV_CONVERSIONS {
                $env.PATH = do $env.ENV_CONVERSIONS.PATH.from_string $env.PATH
              }
            }]
          }
        }
        $env.PATH = ($env.PATH | split row (char esep) | append "~/.cargo/bin")
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
