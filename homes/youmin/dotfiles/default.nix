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
      "opencode/opencode.json".source = link ./opencode/opencode.json;
      "zed/keymap.json".source = link ./zed/keymap.json;
      "zed/settings.json".source = link ./zed/settings.json;
    };
}
