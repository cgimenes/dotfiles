local wezterm = require("wezterm")
local config = wezterm.config_builder()

local is_darwin <const> = wezterm.target_triple:find("darwin") ~= nil
local is_linux <const> = wezterm.target_triple:find("linux") ~= nil

config.enable_wayland = false
config.front_end = "OpenGL"
config.hide_tab_bar_if_only_one_tab = true
config.force_reverse_video_cursor = true
config.colors = require("kanagawa")
config.window_padding = {
	left = 2,
	right = 2,
	top = 2,
	bottom = 2,
}
config.initial_rows = 39
config.initial_cols = 126
config.font = wezterm.font_with_fallback({
	{ family = "Iosevka", weight = "Regular" },
	{ family = "JetBrains Mono", weight = "Medium" },
})
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.window_close_confirmation = "NeverPrompt"
config.window_background_opacity = 1

config.keys = {
	{
		key = "Enter",
		mods = "ALT",
		action = wezterm.action.DisableDefaultAssignment,
	},
}

if is_linux then
	config.font_size = 14.0
	config.window_decorations = "NONE"
end

if is_darwin then
	config.font_size = 18.0
	config.window_decorations = "TITLE|RESIZE|MACOS_FORCE_DISABLE_SHADOW"
	config.macos_window_background_blur = 15
end

return config
