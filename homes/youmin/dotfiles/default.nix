{ impurity, ... }:
{
  xdg.configFile =
    let
      inherit (impurity) link;
    in
    {
      "ideavim".source = link ./ideavim;
      "nvim".source = link ./nvim;
      "nvim-vscode".source = link ./nvim-vscode;
      "ghostty".source = link ./ghostty;
      # "hypr".source = link ./hypr;
      # "rofi".source = link ./rofi;
      "waybar".source = link ./waybar;
      "wlogout".source = link ./wlogout;
      "zed/keymap.json".source = link ./zed/keymap.json;
      "zed/settings.json".source = link ./zed/settings.json;
      "zellij".source = link ./zellij;
    };
}
