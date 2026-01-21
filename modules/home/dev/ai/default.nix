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
  };
}
