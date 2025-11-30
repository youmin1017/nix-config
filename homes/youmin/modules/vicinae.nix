{
  services.vicinae = {
    enable = true; # default: false
    autoStart = true; # default: true
    # package = # specify package to use here. Can be omitted.

    settings = {
      closeOnFocusLoss = false;
      considerPreedit = false;
      faviconService = "twenty";
      font = {
        size = 10.5;
      };
      keybinding = "emacs";
      keybinds = {
        "action.copy" = "control+shift+C";
        "action.copy-name" = "control+shift+.";
        "action.copy-path" = "control+shift+,";
        "action.dangerous-remove" = "control+shift+X";
        "action.duplicate" = "control+D";
        "action.edit" = "control+E";
        "action.edit-secondary" = "control+shift+E";
        "action.move-down" = "control+N";
        "action.move-up" = "control+P";
        "action.new" = "control+RETURN";
        "action.open" = "control+O";
        "action.pin" = "control+shift+P";
        "action.refresh" = "control+R";
        "action.remove" = "control+X";
        "action.save" = "control+S";
        "open-search-filter" = "control+F";
        "open-settings" = "control+,";
        "toggle-action-panel" = "control+K";
      };
      popToRootOnClose = false;
      rootSearch = {
        searchFiles = false;
      };
      theme = {
        name = "vicinae-dark";
      };
      window = {
        csd = true;
        opacity = 0.98;
        rounding = 10;
      };
    };
  };
}
