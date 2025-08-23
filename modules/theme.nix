{
  config,
  pkgs,
  lib,
  ...
}:
{
  catppuccin.flavor = "macchiato";

  stylix = {
    enable = true;
    autoEnable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
  };
}
