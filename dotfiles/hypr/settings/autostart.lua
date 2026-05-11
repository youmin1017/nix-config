hl.on("hyprland.start", function()
  local plugins = {
    "/nix/store/q0harr6z8hfy7503474wsl81isn8847a-split-monitor-workspaces-0.1/lib/libsplit-monitor-workspaces.so",
  }

  for _, plugin in ipairs(plugins) do
    hl.exec_cmd("hyprctl plugin load " .. plugin)
  end

  hl.exec_cmd("noctalia-shell")
end)
