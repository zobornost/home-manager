{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs = {
    bash = {
      enable = true;
      enableCompletion = true;
      initExtra = ''
        source "${pkgs.blesh}/share/blesh/ble.sh"
        eval "$(direnv hook bash)"
        nixos() {
          if [ "$1" = "update" ]; then
            sudo echo "Updating nixos"
            nix flake update --flake ~/.config/nixos && sudo nixos-rebuild switch --flake ~/.config/nixos
          fi
        }
        home() {
          if [ "$1" = "update" ]; then
            echo "Updating home-manager"
            nix flake update --flake ~/.config/home-manager && home-manager switch --flake ~/.config/home-manager
          fi
        }
      '';
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
      enableBashIntegration = false;
      settings = {
        character = {
          success_symbol = "[](green)";
          error_symbol = "[](red)";
        };
      };
    };
  };
}
