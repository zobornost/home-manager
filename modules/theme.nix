{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    yaru-theme
  ];

  catppuccin = {
    enable = true;
    accent = "rosewater";
    flavor = "macchiato";
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        icon-theme  = "Yaru-magenta-dark";
        cursor-theme = "Yaru";
      };
    };
  };
}
