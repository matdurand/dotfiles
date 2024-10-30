-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

config.colors = {
	foreground = "#dcdddd",
	background = "#2a353a",
	cursor_bg = "#47FF9C",
	cursor_border = "#47FF9C",
	cursor_fg = "#011423",
	selection_bg = "#033259",
	selection_fg = "#CBE0F0",
	ansi = { "#000000", "#ee7e7b", "#90c16a", "#c6c144", "#86c4f5", "#a796b9", "#60a6b7", "#d6d6d6" },
	brights = { "#636363", "#da5470", "#abdd8e", "#ddde4d", "#52abdb", "#b4a3d7", "#95c5d2", "#bfc1bc" },
}

config.font = wezterm.font("FiraCode Nerd Font", { weight = "Medium" })
config.font_size = 13

config.enable_tab_bar = true

config.window_background_opacity = 1
config.macos_window_background_blur = 10
config.scrollback_lines = 10000
config.enable_scroll_bar = true

config.keys = {
	-- Clears the scrollback and viewport leaving the prompt line the new first line.
	{
		key = "k",
		mods = "SUPER",
		action = act.ClearScrollback("ScrollbackAndViewport"),
	},
}

-- and finally, return the configuration to wezterm
return config
