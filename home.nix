{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./modules/gnome-extensions.nix
    ./modules/packages.nix
    ./modules/programs.nix
    ./modules/shells.nix
    ./modules/ssh.nix
    ./modules/theme.nix
  ];

  home = {
    username = "oz";
    homeDirectory = "/home/oz";
    sessionVariables = {
      EDITOR = "code";
      TERMINAL = "ghostty";
      NIXOS_OZONE_WL = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
    };
    stateVersion = "24.11"; # Please read the comment before changing.
  };
}
