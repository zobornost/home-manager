{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./modules/packages.nix
    ./modules/programs.nix
    ./modules/shells.nix
    #./modules/ssh.nix
    ./modules/theme.nix
  ];

  home = {
    username = "zoe";
    homeDirectory = "/home/zoe";
    stateVersion = "24.11"; # Please read the comment before changing.
  };

  news.display = "silent";
}