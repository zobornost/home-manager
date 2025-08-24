{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs = {
    home-manager.enable = true;

    chromium = {
      enable = true;
      extensions = [
        "aeblfdkhhhdcdjpifhhbdiojplfjncoa" # 1password
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
      ];
    };

    direnv = {
      enable = true;
      config = {
        hide_env_diff = true;
      };
    };

    git = {
      enable = true;
      extraConfig.init.defaultBranch = "main";
      userName = "Zoe Browning";
      userEmail = "56755170+ozmodeuz@users.noreply.github.com";
    };

    micro = {
      enable = true;
      settings = {
        "Alt-/" = "lua:comment.comment";
        "CtrlUnderscore" = "lua:comment.comment";
      };
    };
  };
}
