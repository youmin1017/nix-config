{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.myHome.dev.ai.enable = lib.mkEnableOption "Enable AI development tools.";

  config = lib.mkIf config.myHome.dev.ai.enable {
    home.packages = with pkgs; [
      # CLI Tools
      opencode
      gemini-cli
      github-copilot-cli
    ];

    # Dependencies
    myHome = {
      dev = {
        node.enable = true;
      };

      programs.neovim.lazyvim.extras = [
        "lazyvim.plugins.extras.ai.copilot-native"
        "lazyvim.plugins.extras.ai.sidekick"
      ];
    };
  };
}
