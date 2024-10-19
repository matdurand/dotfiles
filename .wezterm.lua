-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- my coolnight colorscheme
config.colors = {
	foreground = "#CBE0F0",
	background = "#011423",
	cursor_bg = "#47FF9C",
	cursor_border = "#47FF9C",
	cursor_fg = "#011423",
	selection_bg = "#033259",
	selection_fg = "#CBE0F0",
	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
}

config.font = wezterm.font("MesloLGS Nerd Font Mono",{ weight = 'Bold'})
config.font_size = 14

config.enable_tab_bar = true

config.window_decorations = "TITLE | RESIZE"

config.window_background_opacity = 1
config.macos_window_background_blur = 10

config.keys = {
  -- Clears the scrollback and viewport leaving the prompt line the new first line.
  {
    key = 'k',
    mods = 'SUPER',
    action = act.ClearScrollback 'ScrollbackAndViewport',
  }
}

-- and finally, return the configuration to wezterm
return config