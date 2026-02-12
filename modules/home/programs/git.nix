{
  config,
  lib,
  ...
}:
{
  options.myHome.programs.git = {
    enable = lib.mkEnableOption "ghostty terminal emulator";
    user = {
      name = lib.mkOption {
        description = "Username for Git commits";
        type = lib.types.nullOr lib.types.str;
        default = null;
      };
      email = lib.mkOption {
        description = "Email address for Git commits";
        type = lib.types.nullOr lib.types.str;
        default = null;
      };
    };
  };

  config = lib.mkIf config.myHome.programs.git.enable {
    programs = {
      git = {
        enable = true;
        settings = {
          lfs.enable = true;
          user = {
            name = config.myHome.programs.git.user.name;
            email = config.myHome.programs.git.user.email;
          };
          init.defaultBranch = "main";
          push.autoSetupRemote = true;
          pull.rebase = true;
          alias = {
            # common aliases
            br = "branch";
            co = "checkout";
            st = "status";
            ls = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate";
            ll = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate --numstat";
            cm = "commit -m";
            ca = "commit -am";
            dc = "diff --cached";
            amend = "commit --amend -m";

            # aliases for submodule
            update = "submodule update --init --recursive";
            foreach = "submodule foreach";
          };
        };
        ignores = [
          ".DS_Store"
          "Thumbs.db"
          ".idea"
        ];
      };

      delta = {
        enable = true;
        enableGitIntegration = true;
        options = {
          features = "side-by-side";
        };
      };
    };
  };
}
