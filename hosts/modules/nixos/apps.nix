{
  inputs,
  config,
  pkgs,
  ...
}:
{
  environment.systemPackages =
    with pkgs;
    if config.hardware.graphics.enable then
      [
        # browsers
        inputs.zen-browser.packages."x86_64-linux".default # beta
        brave
        vivaldi

        ghostty
        onlyoffice-desktopeditors
        prismlauncher
        remmina
        spotify
        sticky
        teams-for-linux
        vlc # media player
        thunderbird # email client
        wl-clipboard
        nautilus # file manager
        telegram-desktop
        spotify
        bruno

        # editors
        jetbrains.datagrip
        jetbrains.goland
        zed-editor
        antigravity

        # overrides
        (bottles.override { removeWarningPopup = true; })
        (discord.overrideAttrs (oldAttrs: {
          postInstall = (oldAttrs.postInstall or "") + ''
            wrapProgram $out/bin/discord \
              --add-flags "--enable-wayland-ime"
          '';
        }))
      ]
    else
      [ ];

  programs.steam.enable = true;
}
