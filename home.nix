{
  config,
  pkgs,
  inputs,
  ...
}:
{
  home.username = "oz";
  home.homeDirectory = "/home/oz";
  home.stateVersion = "24.11";
  home.packages = with pkgs; [
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
  home.sessionVariables = {
    EDITOR = "code";
    TERMINAL = "ghostty";
  };
  nixpkgs.config.allowUnfree = true;
  programs = {
    bash.enable = true;
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
  systemd.user.sessionVariables = {
    GDK_BACKEND = "wayland";
    NIXOS_OZONE_WL = "1";
    OZONE_PLATFORM = "wayland";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}
