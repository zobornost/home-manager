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
      category-icon-type = "Symbolic";
      custom-menu-button-icon-size = 26.0;
      default-menu-view = "Frequent_Apps";
      default-menu-view-tognee = "All_Programs";
      disable-user-avatar = false;
      distro-icon = 2;
      enable-horizontal-flip = false;
      force-menu-location = "BottomLeft";
      hide-overview-on-startup = true;
      left-panel-width = 240;
      menu-background-color = "rgb(30,30,46)";
      menu-border-color = "rgb(46,46,61)";
      menu-button-appearance = "Icon";
      menu-button-bg-color = lib.hm.gvariant.mkTuple [ false "rgba(255,255,255,0)" ];
      menu-button-border-radius = lib.hm.gvariant.mkTuple [ false 0 ];
      menu-button-border-width = lib.hm.gvariant.mkTuple [ false 0 ];
      menu-button-hover-bg-color = lib.hm.gvariant.mkTuple [ false "rgba(135,112,167,0.246667)" ];
      menu-button-icon = "Menu_Icon";
      menu-button-position-offset = 0;
      menu-foreground-color = "rgb(205,214,244)";
      menu-item-active-bg-color = "rgb(49,50,68)";
      menu-item-active-fg-color = "rgb(205,214,244)";
      menu-item-hover-bg-color = "rgb(46,46,61)";
      menu-item-hover-fg-color = "rgb(205,214,244)";
      menu-layout = "Default";
      menu-position-alignment = 50;
      menu-separator-color = "rgba(255,255,255,0.1)";
      multi-monitor = true;
      override-menu-theme = false;
      position-in-panel = "Left";
      prefs-visible-page = 0;
      recently-installed-apps = [];
      runner-hotkey = [ "Super_L" ];
      runner-position = "Centered";
      runner-search-display-style = "Grid";
      runner-show-frequent-apps = true;
      search-entry-border-radius = lib.hm.gvariant.mkTuple [ true (lib.hm.gvariant.mkInt32 25) ];
      shortcut-icon-type = "Symbolic";
      show-activities-button = true;
      update-notifier-project-version = 65;
      vert-separator = true;
    };

    "org/gnome/shell/extensions/dash-to-panel" = {
      animate-appicon-hover = true;
      animate-appicon-hover-animation-type = "RIPPLE";
      appicon-margin = 0;
      appicon-padding = 8;
      appicon-style = "NORMAL";
      dot-color-1 = "#8b69bc";
      dot-color-2 = "#8b69bc";
      dot-color-3 = "#8b69bc";
      dot-color-4 = "#8b69bc";
      dot-color-dominant = false;
      dot-color-override = true;
      dot-color-unfocused-1 = "#5b4b71";
      dot-color-unfocused-2 = "#5b4b71";
      dot-color-unfocused-3 = "#5b4b71";
      dot-color-unfocused-4 = "#5b4b71";
      dot-color-unfocused-different = true;
      dot-position = "BOTTOM";
      dot-size = 5;
      dot-style-focused = "DOTS";
      dot-style-unfocused = "DOTS";
      extension-version = 68;
      focus-highlight = false;
      focus-highlight-color = "#313244";
      focus-highlight-dominant = false;
      focus-highlight-opacity = 75;
      global-border-radius = 1;
      group-apps = true;
      group-apps-underline-unfocused = true;
      group-apps-use-fixed-width = true;
      group-apps-use-launchers = false;
      hide-overview-on-startup = true;
      highlight-appicon-hover = true;
      highlight-appicon-hover-background-color = "rgba(220,138,221,0.17)";
      highlight-appicon-hover-border-radius = 0;
      hotkeys-overlay-combo = "TEMPORARILY";
      intellihide = false;
      intellihide-only-secondary = false;
      intellihide-show-in-fullscreen = false;
      leftbox-padding = -1;
      middle-click-action = "MINIMIZE";
      overview-click-to-exit = true;
      panel-anchors = "{\"RHT-0x00000000\":\"MIDDLE\"}";
      panel-element-positions = "{\"RHT-0x00000000\":[{\"element\":\"showAppsButton\",\"visible\":false,\"position\":\"stackedTL\"},{\"element\":\"activitiesButton\",\"visible\":false,\"position\":\"stackedTL\"},{\"element\":\"leftBox\",\"visible\":true,\"position\":\"stackedTL\"},{\"element\":\"centerBox\",\"visible\":true,\"position\":\"centerMonitor\"},{\"element\":\"taskbar\",\"visible\":true,\"position\":\"centerMonitor\"},{\"element\":\"rightBox\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"dateMenu\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"systemMenu\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"desktopButton\",\"visible\":true,\"position\":\"stackedBR\"}]}";
      panel-lengths = "{\"RHT-0x00000000\":100}";
      panel-positions = "{\"RHT-0x00000000\":\"BOTTOM\"}";
      panel-side-margins = 0;
      panel-side-padding = 0;
      panel-sizes = "{\"RHT-0x00000000\":40}";
      panel-top-bottom-margins = 0;
      panel-top-bottom-padding = 0;
      prefs-opened = false;
      primary-monitor = "RHT-0x00000000";
      shift-click-action = "LAUNCH";
      shift-middle-click-action = "LAUNCH";
      show-apps-icon-file = "";
      show-apps-icon-side-padding = 0;
      show-favorites = true;
      show-favorites-all-monitors = true;
      show-running-apps = true;
      show-showdesktop-hover = true;
      show-showdesktop-time = 1000;
      status-icon-padding = -1;
      stockgs-keep-dash = false;
      stockgs-keep-top-panel = false;
      stockgs-panelbtn-click-only = false;
      trans-bg-color = "#1b1b2a";
      trans-dynamic-anim-target = 0.65;
      trans-dynamic-distance = 1;
      trans-gradient-bottom-color = "#dc8add";
      trans-gradient-bottom-opacity = 0.75;
      trans-gradient-top-color = "#ffffff";
      trans-gradient-top-opacity = 0.15;
      trans-panel-opacity = 0.4;
      trans-use-custom-bg = false;
      trans-use-custom-gradient = false;
      trans-use-custom-opacity = true;
      trans-use-dynamic-opacity = true;
      tray-padding = -1;
      tray-size = 0;
      window-preview-title-position = "TOP";
    };

    "org/gnome/shell/extensions/gsconnect" = {
      devices = [];
      id = "b14b9c14-ca6b-44f1-9021-32ed7fce634f";
      name = "book";
    };
  };
}
