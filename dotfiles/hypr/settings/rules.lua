-- Fix DataGrip hover flickering
hl.window_rule({ match = { class = "jetbrains-(.*)", title = "^win(.*)" }, no_initial_focus = true })

-- Floating rules
hl.window_rule({ match = { class = "^(xdg-desktop-portal-gtk)$" }, float = true })

-- Layer rules
hl.layer_rule({ match = { namespace = "vicinae" }, blur = true, ignore_alpha = 1 })
