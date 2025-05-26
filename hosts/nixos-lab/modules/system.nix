{ config, ... }:
{
  fileSystems =
    let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      secretPath = config.sops.secrets."wke/syncwke_secret".path;

      mountPoints = [
        "home"
        "Public"
        "EAS_RW"
      ];
    in
    builtins.listToAttrs (
      map (mountPoint: {
        name = "/mnt/syncwke/${mountPoint}";
        value = {
          device = "//syncwke.csie.ncnu.edu.tw/${mountPoint}";
          fsType = "cifs";
          options = [ "${automount_opts},credentials=${secretPath}" ];
        };
      }) mountPoints
    );

  sops.secrets."wke/syncwke_secret" = { };

  # Keyboard remap by Kanata
  services.kanata = {
    enable = true;
    keyboards = {
      internalKeyboard = {
        devices = [
          "/dev/input/by-id/usb-Keychron_QingNiao_75-event-kbd"
          "/dev/input/by-id/usb-Keychron_QingNiao_75-if02-event-kbd"
        ];
        extraDefCfg = ''
          process-unmapped-keys yes
        '';
        config = ''
          (defvar
           tap-time 100
           hold-time 100
          )
          (defsrc
            esc  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12
            grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
            tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
            caps a    s    d    f    g    h    j    k    l    ;    '    ret
            lsft z    x    c    v    b    n    m    ,    .    /    rsft
            lctl lalt lmet           spc            ralt rmet rctl
          )
          (defalias
           lmet (layer-toggle meta)
           mts (layer-toggle meta-shift)

           ;; Meta Layer Specific
           cpy C-ins   ;; Copy
           pst S-ins   ;; Paste
           cut C-x     ;; Cut
           udo C-z     ;; Undo
           fnd C-f     ;; Find
           sav C-s     ;; Save
           all C-/     ;; Select all
           lok M-l     ;; Lock Screen
           tab (multi alt tab)

           ;; Meta Shift Layer Specific
           nxt C-tab   ;; Next tab
           prv C-S-tab ;; Previous tab
          )
          (deflayer base
            esc  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12
            grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
            tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
            caps a    s    d    f    g    h    j    k    l    ;    '    ret
            lsft z    x    c    v    b    n    m    ,    .    /    rsft
            lctl lalt @lmet          spc            rmet _    rctl
          )
          (deflayer meta
            esc   f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12
            A-grv 1    2    3    4    5    6    7    8    9    0    -    =    bspc
            @tab  q    C-w  e    C-r  C-t  y    u    i    o    p    [    ]    \
            caps  @all s    C-d  @fnd g    h    j    k    C-l  ;    '    ret
            @mts  @udo @cut @cpy @pst b    n    m    ,    .    /    rsft
            lctl  lalt lmet           spc            ralt _ rctl
          )
          (deflayer meta-shift
            esc  f1   f2   f3    f4    f5   f6   f7   f8   f9     f10  f11  f12
            grv  1    2    3     prtsc 5     6    7    8    9     0    -    =    bspc
            tab  M-l  w    e     r     C-S-t y    u    i    o     p    @prv @nxt \
            caps a    s    d     f     g     h    j    k    C-S-l ;    '    ret
            lsft z    x    C-S-c C-S-v b     n    m    ,    .     /    rsft
            lctl lalt lmet             spc             ralt _ rctl
          )
        '';
      };
    };
  };
}
