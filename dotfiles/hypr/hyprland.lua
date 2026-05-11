hl.monitor({
  output = "DP-3",
  mode = "2560x1440@180",
  position = "0x0",
})
hl.monitor({
  output = "DP-2",
  mode = "2560x1440@180",
  position = "-2560x0",
})

require("settings.config")
require("settings.bindings")
require("settings.rules")

-- autostart applications & load plugins
require("settings.autostart")
require("settings.plugins")
