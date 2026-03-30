{
  impurity,
  self,
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.myHome.programs.noctalia;
in
{
  options.myHome.programs.noctalia.enable = lib.mkEnableOption "noctalia shell program module";

  imports = [
    self.inputs.noctalia.homeModules.default
  ];

  config = lib.mkIf cfg.enable {
    programs.noctalia-shell = {
      enable = true;
      systemd.enable = true;
    };

    home.packages = with pkgs; [
      # plugin: screen-toolkit dependencies
      grim
      slurp
      wl-clipboard
      imagemagick
      zbar
      curl
      translate-shell
      wf-recorder
      ffmpeg
      gifski

      # tesseract
      (pkgs.tesseract.override {
        enableLanguages = [
          "eng"
          "chi_tra"
        ];
      })
    ];

    xdg.configFile."noctalia".source = impurity.link "${self}/dotfiles/noctalia";
  };
}
