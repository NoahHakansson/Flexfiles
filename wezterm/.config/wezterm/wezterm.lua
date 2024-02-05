-- Pull in the wezterm API
local wezterm = require('wezterm')
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
  table.insert(copy_mode, { key = '/', mods = 'NONE', action = act({ Search = { CaseInSensitiveString = '' } }) })
end

wezterm.on('update-right-status', function(window, pane)
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
-- config.color_scheme = "Catppuccin Mocha"
config.color_scheme = 'OneDark (base16)'
config.font = wezterm.font('JetBrains Mono')
config.window_background_opacity = 1
config.macos_window_background_blur = 20
config.font_size = 20
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.window_decorations = 'RESIZE'

-- key bindings
-- Leader is the same as my old tmux prefix
config.leader = { key = 's', mods = 'ALT' }
config.keys = {
  -- splitting
  { mods = 'LEADER', key = '-', action = act.SplitVertical({ domain = 'CurrentPaneDomain' }) },
  { mods = 'LEADER', key = '/', action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }) },
  -- Prompt for a name to use for a new workspace and switch to it.
  {
    key = 'n',
    mods = 'LEADER',
    action = act.PromptInputLine({
      description = wezterm.format({
        { Attribute = { Intensity = 'Bold' } },
        { Foreground = { AnsiColor = 'Blue' } },
        { Text = 'Enter name for new workspace' },
      }),
      action = newWorkspaceWithName,
    }),
  },
  -- Show the launcher and have it list all workspaces
  -- and allow activating one.
  { key = 's', mods = 'LEADER', action = act.ShowLauncherArgs({ flags = 'FUZZY|WORKSPACES' }) },
  { key = 'c', mods = 'LEADER', action = act({ SpawnTab = 'CurrentPaneDomain' }) },
  { key = 'q', mods = 'LEADER', action = act({ CloseCurrentPane = { confirm = true } }) },
  { key = 'l', mods = 'ALT', action = act.ActivateTabRelative(1) },
  { key = 'h', mods = 'ALT', action = act.ActivateTabRelative(-1) },
  { key = 'v', mods = 'LEADER', action = act.ActivateCopyMode },
}

config.key_tables = {
  copy_mode = copy_mode,
}

local function mysplit(inputstr, sep)
  if sep == nil then
    sep = '%s'
  end
  local t = {}
  for str in string.gmatch(inputstr, '([^' .. sep .. ']+)') do
    table.insert(t, str)
  end
  return t
end

-- this is called by the mux server when it starts up.
-- It makes a window split top/bottom
local mux = wezterm.mux
wezterm.on('gui-startup', function()
  local flexfiles_dir = wezterm.home_dir .. '/Flexfiles'
  local _, pane, window = mux.spawn_window({
    workspace = 'Flexfiles',
    cwd = flexfiles_dir,
  })
  window:spawn_tab({})
  window:spawn_tab({})
  pane:activate()

  -- logs the names of all of the entries under `/work`
  wezterm.log_error('entries in /work:')
  local work_dir = wezterm.home_dir .. '/work'
  for _, v in ipairs(wezterm.read_dir(work_dir)) do
    -- split string on the / character and get the last element
    local filename = mysplit(v, '/')
    -- remove entry if it contains a . character (i.e. it's a file)
    if string.find(filename[#filename], '%.') then
      wezterm.log_error('filename:', filename[#filename], 'was not a directory')
      table.remove(filename, #filename)
    else
      -- spawn a new tab for each directory
      local _, p, w = mux.spawn_window({
        workspace = filename[#filename],
        cwd = v,
      })
      w:spawn_tab({})
      w:spawn_tab({})
      p:activate()
    end
  end
end)

-- and finally, return the configuration to wezterm
return config
