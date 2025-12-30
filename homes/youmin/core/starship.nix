{
  programs.starship = {
    enable = true;

    enableBashIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = false;

    settings = {
      container.disabled = true;
      add_newline = false;
      character = {
        success_symbol = "[➜](bold #9ece6a)";
        error_symbol = "[➜](bold #f7768e)";
        vimcmd_symbol = "[](bold #7aa2f7)";
      };
      aws = {
        symbol = "🅰 ";
      };
      gcloud = {
        # do not show the account/project's info
        # to avoid the leak of sensitive information when sharing the terminal
        format = "on [$symbol$active(\($region\))]($style) ";
        symbol = "🅶 ️";
      };
    };
  };
}
