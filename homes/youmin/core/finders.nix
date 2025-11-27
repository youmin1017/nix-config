{
  programs = {
    bat = {
      enable = true;
    };
    fd = {
      enable = true;
      ignores = [
        ".git/"
        "*.bak"
        "node_modules/"
        "build/"
      ];
    };
    fzf = {
      enable = true;
      defaultCommand = "fd --hiden --strip-cwd-prefix";
      defaultOptions = [
        "--color=dark"
        "--height 50%"
        "--layout=default"
        "--border"
      ];

      fileWidgetCommand = "fd --type f --hidden --strip-cwd-prefix";
      fileWidgetOptions = [
        "--preview"
        "'bat --color=always -n --line-range :500 {}'"
      ];

      # dracula
      colors = {
        "fg" = "-1";
        "bg" = "-1";
        "hl" = "#5fff87";
        "fg+" = "-1";
        "bg+" = "-1";
        "hl+" = "#ffaf5f";
        "info" = "#af87ff";
        "prompt" = "#5fff87";
        "pointer" = "#ff87d7";
        "marker" = "#ff87d7";
        "spinner" = "#ff87d7";
      };
    };
  };
}
