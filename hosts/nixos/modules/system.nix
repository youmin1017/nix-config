{ lib, pkgs, ... }:
{
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };

  # Keyboard
  hardware.keyboard.qmk.enable = true;
  ## Uinput
  hardware.uinput.enable = true;
  boot.kernelModules = [ "uinput" ];
  users.groups.uinput = { };
  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';
  systemd.services.kanata-internalKeyboard.serviceConfig = {
    SupplementaryGroups = [
      "input"
      "uinput"
    ];
  };

  # Virtualization
  # virtualisation.containers.enable = true;
  virtualisation.docker = {
    enable = true;
  };

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      fcitx5-rime
      rime-data
    ];
  };

  fonts.packages = with pkgs; [
    material-design-icons
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    font-awesome
    nerd-fonts.dejavu-sans-mono
  ];

  services.keyd = {
    enable = false;
    keyboards = {
      default = {
        ids = [ "*" ]; # what goes into the [id] section, here we select all keyboard
        # extraConfig = builtins.readFile /home/deftdawg/source/meta-mac/keyd/kde-mac-keyboard.conf; # use includes when debugging, easier to edit in vscode
        extraConfig = ''
          # Make Apple keyboards work the same way on KDE as they do on MacOS
          [main]
          # Bind both "Cmd" keys to trigger the 'meta_mac' layer
          leftmeta = layer(meta_mac)
          rightalt = rightmeta

          shift = oneshot(shift)
          control = overload(control, esc)

          # By default meta_mac = Ctrl+<key>, except for mappings below
          [meta_mac:C]
          # Use alternate Copy/Cut/Paste bindings from Windows that won't conflict with Ctrl+C used to break terminal apps
          # Copy (works everywhere (incl. vscode term) except Konsole)
          c = C-insert
          # Paste
          v = S-insert
          # Cut
          x = S-delete
          a = C-/

          # FIXME: for Konsole, we must create a shortcut in our default Konsole profile to bind Copy's Alternate to 'Ctrl+Ins'

          # Switch directly to an open tab (e.g., Firefox, VS Code)
          1 = A-1
          2 = A-2
          3 = A-3
          4 = A-4
          5 = A-5
          6 = A-6
          7 = A-7
          8 = A-8
          9 = A-9
          ` = A-`
          ] = C-tab
          [ = C-S-tab


          # Move cursor to the beginning of the line
          left = home
          # Move cursor to the end of the line
          right = end

          # As soon as 'tab' is pressed (but not yet released), switch to the 'app_switch_state' overlay
          tab = swapm(app_switch_state, A-tab)

          [app_switch_state:A]
          # Being in this state holds 'Alt' down allowing us to switch back and forth with tab or arrow presses
        '';
      };
    };
  };
}
