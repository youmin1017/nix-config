{
  services.kanata.keyboards.Compx_2_4G_Wireless = {
    devices = [
      "/dev/input/by-id/usb-Compx_2.4G_Wireless_Receiver-event-kbd"
      "/dev/input/by-id/usb-Compx_2.4G_Wireless_Receiver-event-if01"
    ];
    extraDefCfg = ''
      process-unmapped-keys yes
    '';
    config = ''
      (defsrc
        caps a    s    d    f    g    h    j    k    l    ;    '    ret
        lctl lalt lmet           spc            ralt rmet rctl
      )
      (defalias
       caps (layer-while-held nav)
      )
      (deflayer base
        lctl a    s    d    f    g    h    j    k    l    ;    '    ret
        @caps lmet lalt           spc            ralt rmet rctl
      )
      (deflayer nav
        _    _    _    _    _    _    left down up   rght _    _    _
        _    _    _              _              _    _    _
      )
    '';
  };
}
