{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      # Fix DataGrip hover flickering
      "match:class jetbrains-datagrip, match:title ^win(.*), no_initial_focus 1"

      # Floating rules
      "match:class ^(xdg-desktop-portal-gtk)$, float 1"
      "match:class ^(brave-nngceckbapebfimnlniiiahkandclblb-Default)$, float 1"
    ];
    layerrule = [
      "match:namespace vicinae, blur 1"
      "match:namespace vicinae, ignore_alpha 1"
    ];
  };
}
