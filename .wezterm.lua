local wezterm = require("wezterm")
local config = {}

local custom_onedark = wezterm.color.get_builtin_schemes()["One Dark (Gogh)"]
custom_onedark.foreground = "#ABB2BF"

config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "NONE"
config.color_schemes = {
  ["Custom One Dark"] = custom_onedark,
}
config.color_scheme = "Custom One Dark"
config.font = wezterm.font("TerminessNerdFont")

config.disable_default_key_bindings = true
config.keys = {
  {
    key = "t",
    mods = "SUPER",
    action = wezterm.action.DisableDefaultAssignment,
  },
  { key = "v", mods = "CTRL", action = wezterm.action.PasteFrom "Clipboard" },
  {
    key = "-",
    mods = "CTRL",
    action = wezterm.action.DecreaseFontSize,
  },
  {
    key = "=",
    mods = "CTRL",
    action = wezterm.action.IncreaseFontSize,
  },
  {
    key = "0",
    mods = "CTRL",
    action = wezterm.action.ResetFontSize,
  },
}
config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = "Left"} },
    mods = "NONE",
    action = wezterm.action.CompleteSelection "ClipboardAndPrimarySelection",
  },
  -- Ctrl-click will open the link under the mouse cursor
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "CTRL",
    action = wezterm.action.OpenLinkAtMouseCursor,
  },
  -- Disable the Ctrl-click down event to stop programs from seeing it when a URL is clicked
  {
    event = { Down = { streak = 1, button = "Left" } },
    mods = "CTRL",
    action = wezterm.action.Nop,
  },
}
return config
