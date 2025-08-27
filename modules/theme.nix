{
  config,
  pkgs,
  lib,
  ...
}:
{
  catppuccin = {
    enable = true;
    accent = "lavender";
    flavor = "macchiato";

    btop.enable = true;
    chromium.enable = true;
    cursors.enable = true;
    ghostty.enable = true;
    micro.enable = true;
    starship.enable = true;
    vscode.profiles.default.enable = true;
    zed.enable = true;
  };
}
