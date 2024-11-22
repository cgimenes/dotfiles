local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.front_end = "OpenGL"
config.hide_tab_bar_if_only_one_tab = true
config.force_reverse_video_cursor = true
config.colors = {
	foreground = "#dcd7ba",
	background = "#1f1f28",

	cursor_bg = "#c8c093",
	cursor_fg = "#c8c093",
	cursor_border = "#c8c093",

	selection_fg = "#c8c093",
	selection_bg = "#2d4f67",

	scrollbar_thumb = "#16161d",
	split = "#16161d",

	ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
	brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
	indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
}
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.initial_rows = 39
config.initial_cols = 126
config.window_decorations = "TITLE|RESIZE|MACOS_FORCE_DISABLE_SHADOW"
config.font = wezterm.font_with_fallback({
	{ family = "Iosevka Term", weight = "Medium" },
	{ family = "JetBrains Mono", weight = "Medium" },
})
config.font_size = 18.0
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.window_close_confirmation = "NeverPrompt"
config.window_background_opacity = 0.92
config.macos_window_background_blur = 15

config.keys = {
	{
		key = "Enter",
		mods = "ALT",
		action = wezterm.action.DisableDefaultAssignment,
	},
}

return config
