hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + G", hl.dsp.window.float({ action = "toggle" }))

hl.bind("SUPER + CTRL + Q", hl.dsp.exec_cmd("noctalia-shell ipc call lockScreen lock"))
hl.bind("SUPER + SHIFT + comma", hl.dsp.exec_cmd("noctalia-shell ipc call settings toggle"))

hl.bind("SUPER + SPACE", hl.dsp.exec_cmd("vicinae toggle"))
hl.bind("SUPER + p", hl.dsp.exec_cmd("ghostty"))

hl.bind("Print", hl.dsp.exec_cmd("hyprshot -m region --freeze"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("hyprshot -m window --freeze"))
hl.bind("CTRL + Print", hl.dsp.exec_cmd("hyprshot -m output --freeze"))

hl.bind("SUPER + h", hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + l", hl.dsp.focus({ direction = "r" }))
hl.bind("SUPER + k", hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + j", hl.dsp.focus({ direction = "d" }))

hl.bind("SUPER + SHIFT + h", hl.dsp.window.move({ direction = "l" }))
hl.bind("SUPER + SHIFT + l", hl.dsp.window.move({ direction = "r" }))
hl.bind("SUPER + SHIFT + k", hl.dsp.window.move({ direction = "u" }))
hl.bind("SUPER + SHIFT + j", hl.dsp.window.move({ direction = "d" }))

-- Plugin: Split Monitor Workspaces
local smw = hl.plugin.split_monitor_workspaces
for i = 1, 9 do
  hl.bind("SUPER + " .. i, function()
    smw.workspace(i)
  end)
  hl.bind("SUPER + SHIFT + " .. i, function()
    smw.move_to_workspace_silent(i)
  end)
end

hl.bind("SUPER + 0", function()
  smw.workspace(10)
end)
hl.bind("SUPER + SHIFT + 0", function()
  smw.move_to_workspace_silent(10)
end)

hl.bind("SUPER + S", hl.dsp.workspace.toggle_special())
hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special" }))

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), {
  locked = true,
  repeating = true,
})

hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), {
  locked = true,
  repeating = true,
})

hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), {
  locked = true,
})

hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), {
  locked = true,
})

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), {
  locked = true,
  repeating = true,
})

hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), {
  locked = true,
  repeating = true,
})
