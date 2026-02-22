local wezterm = require('wezterm')
local config = {}

local custom_onedark = wezterm.color.get_builtin_schemes()['One Dark (Gogh)']
custom_onedark.foreground = '#ABB2BF'

config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = 'NONE'
config.color_schemes = {
  ['Custom One Dark'] = custom_onedark,
}
config.color_scheme = 'Custom One Dark'
config.enable_wayland = false
config.font = wezterm.font('TerminessNerdFont')

config.keys = {
  {
    key = 't',
    mods = 'SUPER',
    action = wezterm.action.DisableDefaultAssignment,
  },
  { key = 'v', mods = 'CTRL', action = wezterm.action.PasteFrom 'Clipboard' },
}
return config
