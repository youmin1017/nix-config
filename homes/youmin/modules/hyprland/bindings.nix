{
  wayland.windowManager.hyprland.settings = {
    bind = [
      "SUPER, Q, killactive,"
      "SUPER, G, togglefloating"
      "SUPER CTRL, Q, exec, hyprlock"

      # Launcher
      # Rofi
      # "SUPER, SPACE, exec, pkill -x rofi || rofi -show drun"
      # Vicinae
      "SUPER, SPACE, exec, vicinae toggle"

      # Screenshot
      ", PRINT, exec, hyprshot -m region"
      "SHIFT, PRINT, exec, hyprshot -m window"
      "CTRL, PRINT, exec, hyprshot -m output"

      # Move focus with mod + arrow keys
      "SUPER, h, movefocus, l"
      "SUPER, l, movefocus, r"
      "SUPER, k, movefocus, u"
      "SUPER, j, movefocus, d"

      # Move active window with mod + SHIFT + arrow keys
      "SUPER SHIFT, h, movewindow, l"
      "SUPER SHIFT, l, movewindow, r"
      "SUPER SHIFT, k, movewindow, u"
      "SUPER SHIFT, j, movewindow, d"

      # Workspace
      "SUPER, 1, workspace, 1"
      "SUPER, 2, workspace, 2"
      "SUPER, 3, workspace, 3"
      "SUPER, 4, workspace, 4"
      "SUPER, 5, workspace, 5"
      "SUPER, 6, workspace, 6"
      "SUPER, 7, workspace, 7"
      "SUPER, 8, workspace, 8"
      "SUPER, 9, workspace, 9"
      "SUPER, 0, workspace, 10"
      "SUPER SHIFT, 1, movetoworkspace, 1"
      "SUPER SHIFT, 2, movetoworkspace, 2"
      "SUPER SHIFT, 3, movetoworkspace, 3"
      "SUPER SHIFT, 4, movetoworkspace, 4"
      "SUPER SHIFT, 5, movetoworkspace, 5"
      "SUPER SHIFT, 6, movetoworkspace, 6"
      "SUPER SHIFT, 7, movetoworkspace, 7"
      "SUPER SHIFT, 8, movetoworkspace, 8"
      "SUPER SHIFT, 9, movetoworkspace, 9"
      "SUPER SHIFT, 0, movetoworkspace, 10"

      # Screenshot
      ", Print, exec, grimblast copy area"

      # Example special workspace (scratchpad)
      "SUPER, S, togglespecialworkspace, magic"
      "SUPER SHIFT, S, movetoworkspace, special:magic"
    ];

    bindm = [
      # Move/resize windows with mod + LMB/RMB and dragging
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];
  };
}
