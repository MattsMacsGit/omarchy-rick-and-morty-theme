-- Rick and Morty: portal-green energy rims, lab-dark chrome, cartoon pop-ins.

local active_border_color = { colors = { "rgba(97ce4cee)", "rgba(7fede1dd)" }, angle = 135 }
local inactive_border_color = "rgba(3a284866)"

hl.config({
  general = {
    gaps_in = 6,
    gaps_out = 14,
    border_size = 2,
    col = {
      active_border = active_border_color,
      inactive_border = inactive_border_color,
    },
  },

  group = {
    col = {
      border_active = active_border_color,
      border_inactive = inactive_border_color,
    },
    groupbar = {
      rounding = 8,
      text_color = "rgb(f4e7c3)",
      text_color_inactive = "rgba(f4e7c390)",
      col = {
        active = "rgba(97ce4c40)",
        inactive = "rgba(09021555)",
      },
    },
  },

  decoration = {
    rounding = 8,
    fullscreen_opacity = 1.0,
    dim_inactive = true,
    dim_strength = 0.12,

    blur = {
      enabled = true,
      size = 6,
      passes = 2,
      ignore_opacity = true,
      new_optimizations = true,
      xray = false,
      noise = 0.02,
      contrast = 0.9,
      brightness = 0.78,
      vibrancy = 0.28,
      popups = true,
      popups_ignorealpha = 0.2,
    },

    shadow = {
      enabled = true,
      range = 22,
      render_power = 3,
      offset = { 0, 6 },
      scale = 0.98,
      color = "rgba(97ce4c30)",
      color_inactive = "rgba(03000866)",
    },

    glow = {
      enabled = true,
      range = 12,
      render_power = 3,
      color = "rgba(97ce4c3a)",
      color_inactive = "rgba(97ce4c12)",
    },
  },
})

hl.curve("portal", { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } })
hl.animation({ leaf = "windows", enabled = true, speed = 4.0, bezier = "portal" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.4, bezier = "portal", style = "popin 82%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.6, bezier = "linear", style = "popin 82%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 2.0, bezier = "almostLinear" })
hl.animation({ leaf = "border", enabled = true, speed = 4.8, bezier = "portal" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4.0, bezier = "portal", style = "fade" })

-- Apps stay mostly solid so the neon wallpaper doesn't fight the UI.
-- Terminals go a little thinner so the portal scene can bleed through.
o.window({ tag = "default-opacity" }, { opacity = "0.94 override 0.90 override 1.0 override" })
o.window({ tag = "terminal" }, { opacity = "0.84 override 0.78 override 1.0 override" })

-- Frost the shell so bar, menus, OSD, and notifications pick up portal glow.
hl.layer_rule({
  match = {
    namespace = "^(omarchy-bar|omarchy-menu|omarchy-notifications|omarchy-osd|omarchy-clipboard|omarchy-emojis|omarchy-polkit|omarchy-image-selector|omarchy-reminders)$",
  },
  blur = true,
  ignore_alpha = 0.2,
})

-- Live wallpaper overlay should not fade with other layer surfaces.
hl.layer_rule({
  match = { namespace = "^matt-live-wallpaper$" },
  no_anim = true,
  animation = "none",
})
