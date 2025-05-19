{
  config,
  pkgs,
  inputs,
  ...
}:
{
  home = {
    username = "oz";
    homeDirectory = "/home/oz";
    stateVersion = "24.11"; # Please read the comment before changing.
    packages = with pkgs; [
      _1password-cli
      _1password-gui
      blender
      blockbench
      code-cursor
      chromium
      deskflow
      devbox
      devenv
      discord
      eyedropper
      ghostty
      gnome-network-displays
      gnome-remote-desktop
      godot_4
      google-chrome
      hyfetch
      inkscape
      jdk
      jetbrains-toolbox
      jetbrains.idea-community
      nodejs_22
      nuclear
      prismlauncher
      scribus
      vscode
      windsurf
      zed-editor
    ];
    sessionVariables = {
      EDITOR = "code";
      TERMINAL = "ghostty";
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
      userName = "Zoe Browning";
      userEmail = "56755170+ozmodeuz@users.noreply.github.com";
    };
    home-manager.enable = true;
    gnome-shell = {
      enable = true;
    };
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
      settings = {
        character = {
          success_symbol = "[](green)";
          error_symbol = "[](red)";
        };
      };
    };
  };
  stylix = {
    enable = true;
    autoEnable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  };
}
