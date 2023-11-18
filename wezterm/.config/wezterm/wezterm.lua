-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Catppuccin Mocha'
config.font = wezterm.font 'JetBrains Mono'
config.font_size = 16
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

-- and finally, return the configuration to wezterm
return config
