{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    # ./modules/gnome-extensions.nix  # Disabled to avoid GDM login loop on Silverblue
    ./modules/packages.nix
    ./modules/programs.nix
    ./modules/shells.nix
    ./modules/ssh.nix
    # ./modules/theme.nix  # Disabled to avoid theming/user-theme interactions
  ];

  home = {
    username = "zoe";
    homeDirectory = "/home/zoe";
    sessionVariables = {
      EDITOR = "code";
      TERMINAL = "ghostty";
      NIXOS_OZONE_WL = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
    };
    stateVersion = "24.11"; # Please read the comment before changing.
  };
}
