{
  programs = {
    sesh = {
      enable = true;
      enableAlias = true;
      enableTmuxIntegration = false;
    };
    # sesh required settings
    fzf.tmux.enableShellIntegration = true;
  };
}
