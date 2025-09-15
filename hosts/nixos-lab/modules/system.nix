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

  # Virtualization
  virtualisation.docker.enable = true;
  virtualisation.vmware.host.enable = true;

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
           ;; lmet (layer-toggle meta)
           lmet (multi lmet (layer-while-held meta))
           lmsf (multi lsft (layer-while-held meta-shift)) ;; Meta Shift Layer

           ;; Meta Layer Specific
           ctc (multi (release-key lmet) C-c) ;; Copy
           ctv (multi (release-key lmet) C-v) ;; Paste
           ctx (multi (release-key lmet) C-x) ;; Cut
           ctz (multi (release-key lmet) C-z) ;; Undo
           ctf (multi (release-key lmet) C-f) ;; Find
           cts (multi (release-key lmet) C-s) ;; Save
           ctd (multi (release-key lmet) C-d) ;; Pin current window
           ctr (multi (release-key lmet) C-r) ;; Reload current window
           ctt (multi (release-key lmet) C-t) ;; New tab
           ctw (multi (release-key lmet) C-w) ;; Close current window
           all (multi (release-key lmet) C-/) ;; Select all
           psc (unmod prtsc) ;; Print screen
           cst (multi (release-key lmet) C-S-t) ;; Reopen last closed tab

           ;; Meta Shift Layer Spekcific
           csc (multi (release-key lmet) C-S-c) ;; Copy without formatting
           csv (multi (release-key lmet) C-S-v) ;; Paste without formatting
           nxt (multi (release-key lmet) C-Tab) ;; Next tab
           prv (multi (release-key lmet) C-S-Tab) ;; Previous tab
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
            tab   q    @ctw e    @ctr @ctt y    u    i    o    p    [    ]    \
            caps  @all s    @ctd @ctf g    h    j    k    l    ;    '    ret
            @lmsf @ctz @ctx @ctc @ctv b    n    m    ,    .    /    rsft
            lctl  lalt lmet           spc            ralt _ rctl
          )
          (deflayer meta-shift
            esc  f1   f2   f3   f4    f5   f6   f7   f8   f9    f10  f11  f12
            grv  1    2    3    @psc  5    6    7    8    9     0    -    =    bspc
            tab  q    w    e    r     @cst y    u    i    o     p    @prv @nxt \
            caps a    s    d    f     g    h    j    k    l     ;    '    ret
            lsft z    x    @csc @csv  b    n    m    ,    .     /    rsft
            lctl lalt lmet           spc            ralt _ rctl
          )
        '';
      };
    };
  };
}
