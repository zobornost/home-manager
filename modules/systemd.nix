{ config, pkgs, lib, ... }:
{
  systemd.user.startServices = "sd-switch";

  # Authoritative value for apps (read by systemd --user via ~/.config/environment.d)
  xdg.configFile."environment.d/10-xdg-data-dirs.conf".text = lib.mkForce ''
    XDG_DATA_DIRS=${config.home.homeDirectory}/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share:${config.home.homeDirectory}/.nix-profile/share:/nix/var/nix/profiles/default/share
  '';

  # Ensure the new env is applied immediately after switch
  home.activation.reexecUserSystemd = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.systemd}/bin/systemctl --user daemon-reexec || true
  '';

  # Optional: collapse dupes in interactive bash in case something appends later
  programs.bash.enable = true;
  programs.bash.initExtra = ''
    if [ -n "''${XDG_DATA_DIRS-}" ]; then
      XDG_DATA_DIRS="$(printf %s "''${XDG_DATA_DIRS}" | awk -v RS=: '!a[$0]++{printf NR==1?$0:RS $0}')"
      export XDG_DATA_DIRS
    fi
  '';
}
