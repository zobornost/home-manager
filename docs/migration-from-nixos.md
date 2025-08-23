# NixOS → Home Manager migration: Action list

Only actions to take are listed below. Items already good are omitted.

1) Manage GNOME Shell extensions per-user in Home Manager
- Remove all `gnomeExtensions.*` entries from `environment.systemPackages` in `~/.config/nixos/shared/environment.nix`.
- Define per-user extensions in HM (e.g., `~/.config/home-manager/modules/programs.nix`):
  ```nix
  programs.gnome-shell = {
    enable = true;
    extensions = [
      # e.g. "appindicator" "arcmenu" "blur-my-shell" "dash-to-panel" ...
    ];
  };
  ```

2) De-duplicate allowUnfree configuration
- If no system packages require unfree, remove `nixpkgs.config.allowUnfree = true;` from `~/.config/nixos/shared/nixpkgs.nix` and rely on HM’s setting.
- If system packages do require unfree, keep it in NixOS and optionally drop it from HM to avoid duplication.
