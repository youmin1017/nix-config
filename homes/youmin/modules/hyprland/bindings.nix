{
  wayland.windowManager.hyprland.settings = {
    bind = [
      "SUPER, Q, killactive,"
      "SUPER, G, togglefloating"
      "SUPER CTRL, Q, exec, hyprlock"

      "SUPER SHIFT, comma, exec, noctalia-shell ipc call settings toggle"

      # Launcher
      # Rofi
      # "SUPER, SPACE, exec, pkill -x rofi || rofi -show drun"
      # Vicinae
      "SUPER, SPACE, exec, vicinae toggle"

      # Screenshot
      ", PRINT, exec, hyprshot -m region --freeze"
      "SHIFT, PRINT, exec, hyprshot -m window --freeze"
      "CTRL, PRINT, exec, hyprshot -m output --freeze"

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
      "SUPER, 1, split-workspace, 1"
      "SUPER, 2, split-workspace, 2"
      "SUPER, 3, split-workspace, 3"
      "SUPER, 4, split-workspace, 4"
      "SUPER, 5, split-workspace, 5"
      "SUPER, 6, split-workspace, 6"
      "SUPER, 7, split-workspace, 7"
      "SUPER, 8, split-workspace, 8"
      "SUPER, 9, split-workspace, 9"
      "SUPER, 0, split-workspace, 10"
      "SUPER SHIFT, 1, split-movetoworkspace, 1"
      "SUPER SHIFT, 2, split-movetoworkspace, 2"
      "SUPER SHIFT, 3, split-movetoworkspace, 3"
      "SUPER SHIFT, 4, split-movetoworkspace, 4"
      "SUPER SHIFT, 5, split-movetoworkspace, 5"
      "SUPER SHIFT, 6, split-movetoworkspace, 6"
      "SUPER SHIFT, 7, split-movetoworkspace, 7"
      "SUPER SHIFT, 8, split-movetoworkspace, 8"
      "SUPER SHIFT, 9, split-movetoworkspace, 9"
      "SUPER SHIFT, 0, split-movetoworkspace, 10"

      # Special Workspace (scratchpad)
      "SUPER, S, togglespecialworkspace, magic"
      "SUPER SHIFT, S, movetoworkspace, special:magic"
    ];

    bindm = [
      # Move/resize windows with mod + LMB/RMB and dragging
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];
    bindel = [
      # Laptop multimedia keys for volume and LCD brightness
      ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
      ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
    ];
  };
}
