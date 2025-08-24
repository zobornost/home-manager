{ config, lib, pkgs, ... }:
{
  home.packages =
    (with pkgs; [
      gnome-extension-manager
    ])
    ++
    (with pkgs.gnomeExtensions; [
      arcmenu
      dash-to-panel
      gsconnect
      user-themes
      window-is-ready-remover
      window-title-is-back
      tailscale-qs
      display-configuration-switcher
    ]);

  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = [
        "arcmenu@arcmenu.com"
        "display-configuration-switcher@knokelmaat.gitlab.com"
        "dash-to-panel@jderose9.github.com"
        "gsconnect@andyholmes.github.io"
        "tailscale@joaophi.github.com"
        "windowIsReady_Remover@nunofarruca@gmail.com"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
      ];
    };

    "org/gnome/shell/extensions/arcmenu" = {
      all-apps-button-action = "All_Programs";
      arc-menu-icon = 71;
      button-padding = -1;
      custom-menu-button-icon-size = 32.0;
      default-menu-view = "Frequent_Apps";
      distro-icon = 22;
      force-menu-location = "BottomLeft";
      hide-overview-on-startup = true;
      menu-background-color = "rgb(30,30,46)";
      menu-border-color = "rgb(46,46,61)";
      menu-button-appearance = "Icon";
      menu-button-icon = "Distro_Icon";
      menu-foreground-color = "rgb(205,214,244)";
      menu-item-active-bg-color = "rgb(49,50,68)";
      menu-item-active-fg-color = "rgb(205,214,244)";
      menu-item-hover-bg-color = "rgb(46,46,61)";
      menu-item-hover-fg-color = "rgb(205,214,244)";
      menu-layout = "Default";
      menu-position-alignment = 50;
      menu-separator-color = "rgba(255,255,255,0.1)";
      multi-monitor = true;
      override-menu-theme = true;
      position-in-panel = "Left";
      prefs-visible-page = 0;
      runner-hotkey = [ "Super_L" ];
      runner-position = "Centered";
      runner-search-display-style = "Grid";
      runner-show-frequent-apps = true;
      search-entry-border-radius = lib.hm.gvariant.mkTuple [ true (lib.hm.gvariant.mkInt32 25) ];
      show-activities-button = true;
      vert-separator = true;
    };

    "org/gnome/shell/extensions/dash-to-panel" = {
      appicon-margin = 1;
      appicon-padding = 8;
      appicon-style = "NORMAL";
      dot-color-1 = "#8770a7";
      dot-color-2 = "#8770a7";
      dot-color-3 = "#8770a7";
      dot-color-4 = "#8770a7";
      dot-color-dominant = false;
      dot-color-override = true;
      dot-color-unfocused-1 = "#5b4b71";
      dot-color-unfocused-2 = "#5b4b71";
      dot-color-unfocused-3 = "#5b4b71";
      dot-color-unfocused-4 = "#5b4b71";
      dot-color-unfocused-different = true;
      dot-position = "BOTTOM";
      dot-size = 2;
      dot-style-focused = "METRO";
      dot-style-unfocused = "METRO";
      focus-highlight = true;
      focus-highlight-color = "#313244";
      focus-highlight-dominant = false;
      focus-highlight-opacity = 100;
      global-border-radius = 0;
      group-apps = true;
      group-apps-underline-unfocused = true;
      group-apps-use-fixed-width = true;
      group-apps-use-launchers = false;
      hide-overview-on-startup = true;
      highlight-appicon-hover-background-color = "rgba(220,138,221,0.17)";
      highlight-appicon-hover-border-radius = 0;
      hotkeys-overlay-combo = "TEMPORARILY";
      leftbox-padding = -1;
      middle-click-action = "MINIMIZE";
      panel-side-margins = 0;
      panel-side-padding = 0;
      panel-top-bottom-margins = 0;
      panel-top-bottom-padding = 0;
      prefs-opened = false;
      shift-click-action = "LAUNCH";
      shift-middle-click-action = "LAUNCH";
      show-favorites = true;
      show-favorites-all-monitors = true;
      show-running-apps = true;
      status-icon-padding = -1;
      stockgs-keep-top-panel = false;
      stockgs-panelbtn-click-only = false;
      trans-bg-color = "#1b1b2a";
      trans-gradient-bottom-color = "#dc8add";
      trans-gradient-bottom-opacity = 0.75;
      trans-gradient-top-color = "#ffffff";
      trans-gradient-top-opacity = 0.15;
      trans-panel-opacity = 1.0;
      trans-use-custom-bg = true;
      trans-use-custom-gradient = false;
      trans-use-custom-opacity = false;
      trans-use-dynamic-opacity = false;
      tray-padding = -1;
      window-preview-title-position = "TOP";
    };

    "org/gnome/shell/extensions/gsconnect" = {
      devices = [];
      id = "b14b9c14-ca6b-44f1-9021-32ed7fce634f";
      name = "book";
    };
  };
}
