-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This table will hold the configuration.
-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

local copy_mode = nil
if wezterm.gui then
	copy_mode = wezterm.gui.default_key_tables().copy_mode
	table.insert(copy_mode, { key = "/", mods = "NONE", action = act({ Search = { CaseInSensitiveString = "" } }) })
end

wezterm.on("update-right-status", function(window, pane)
	window:set_right_status(window:active_workspace())
end)

local newWorkspaceWithName = wezterm.action_callback(function(window, pane, line)
	-- line will be `nil` if they hit escape without entering anything
	-- An empty string if they just hit enter
	-- Or the actual line of text they wrote
	if line then
		window:perform_action(
			act.SwitchToWorkspace({
				name = line,
			}),
			pane
		)
	end
end)
-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font("JetBrains Mono")
config.window_background_opacity = 1
config.font_size = 19
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true

-- key bindings
-- Leader is the same as my old tmux prefix
config.leader = { key = "s", mods = "ALT" }
config.keys = {
	-- splitting
	{ mods = "LEADER", key = "-", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ mods = "LEADER", key = "=", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	-- Prompt for a name to use for a new workspace and switch to it.
	{
		key = "n",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = wezterm.format({
				{ Attribute = { Intensity = "Bold" } },
				{ Foreground = { AnsiColor = "Fuchsia" } },
				{ Text = "Enter name for new workspace" },
			}),
			action = newWorkspaceWithName,
		}),
	},
	-- Show the launcher and have it list all workspaces
	-- and allow activating one.
	{
		key = "s",
		mods = "LEADER",
		action = act.ShowLauncherArgs({
			flags = "FUZZY|WORKSPACES",
		}),
	},
	{ key = "c", mods = "LEADER", action = act({ SpawnTab = "CurrentPaneDomain" }) },
	{ key = "x", mods = "LEADER", action = act({ CloseCurrentPane = { confirm = true } }) },
	{ key = "l", mods = "ALT", action = act.ActivateTabRelative(1) },
	{ key = "h", mods = "ALT", action = act.ActivateTabRelative(-1) },
	{ key = "v", mods = "LEADER", action = act.ActivateCopyMode },
}

config.key_tables = {
	copy_mode = copy_mode,
}

-- This causes `wezterm` to act as though it was started as
-- `wezterm connect unix` by default, connecting to the unix
-- domain on startup.
-- If you prefer to connect manually, leave out this line.
config.unix_domains = {
	{
		name = "unix",
	},
}
config.default_gui_startup_args = { "connect", "unix" }

-- and finally, return the configuration to wezterm
return config
