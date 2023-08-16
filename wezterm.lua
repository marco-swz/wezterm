local wezterm = require 'wezterm'
local act = wezterm.action

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  config.default_prog = { 'powershell', '-NoLogo' }
end

config.launch_menu = launch_menu
config.color_scheme = 'nightfox'
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.font = wezterm.font("Hack Nerd Font Mono", {weight="Regular", stretch="Normal", style="Normal"})
config.audible_bell = 'Disabled'
config.font_size = 11
config.tab_bar_at_bottom = true
config.keys = {
  {
    key = 'w',
    mods = 'ALT',
    action = act.ActivateKeyTable {
      name = 'tab',
      one_shot = true,
    },
  },
  {
    key = 'p',
    mods = 'ALT',
    action = act.ActivateKeyTable {
      name = 'pane',
      one_shot = true,
    },
  },
  {
    key = 'm',
    mods = 'ALT',
    action = act.ActivateKeyTable {
      name = 'move',
      one_shot = false,
    },
  },
  {
    key = 'r',
    mods = 'ALT',
    action = act.ActivateKeyTable {
      name = 'resize',
      one_shot = false,
    },
  },
  {
    key = 's',
    mods = 'ALT',
    action = act.ActivateKeyTable {
      name = 'search',
      one_shot = false,
    },
  },
  {
    key = 'f',
    mods = 'ALT',
    action = act.ActivateKeyTable {
      name = 'find',
      one_shot = true,
    },
  },
  {
    key = 'h',
    mods = 'ALT',
    action = act.ActivatePaneDirection "Left",
  },
  {
    key = 'l',
    mods = 'ALT',
    action = act.ActivatePaneDirection "Right",
  },
  {
    key = 'j',
    mods = 'ALT',
    action = act.ActivatePaneDirection "Down",
  },
  {
    key = 'k',
    mods = 'ALT',
    action = act.ActivatePaneDirection "Up",
  },
  {
    key = ',',
    mods = 'ALT',
    action = act.ActivateTabRelative(-1),
  },
  {
    key = '.',
    mods = 'ALT',
    action = act.ActivateTabRelative(1),
  },
  {
    key = '<',
    mods = 'ALT|SHIFT',
    action = act.MoveTabRelative(-1),
  },
  {
    key = '>',
    mods = 'ALT|SHIFT',
    action = act.MoveTabRelative(1),
  },
}
config.key_tables = {
  resize = {
    { key = 'LeftArrow', action = act.AdjustPaneSize { 'Left', 1 } },
    { key = 'h', action = act.AdjustPaneSize { 'Left', 1 } },

    { key = 'RightArrow', action = act.AdjustPaneSize { 'Right', 1 } },
    { key = 'l', action = act.AdjustPaneSize { 'Right', 1 } },

    { key = 'UpArrow', action = act.AdjustPaneSize { 'Up', 1 } },
    { key = 'k', action = act.AdjustPaneSize { 'Up', 1 } },

    { key = 'DownArrow', action = act.AdjustPaneSize { 'Down', 1 } },
    { key = 'j', action = act.AdjustPaneSize { 'Down', 1 } },

    { key = 'Escape', action = 'PopKeyTable' },
  },
  tab = {
    { key = 'n', action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 'x', action = act.CloseCurrentTab { confirm = false }},
  },
  move = {
    { key = 'p', action = act.PaneSelect {
	    mode = 'SwapWithActive',
    }},
    { key = ',', action = act.MoveTabRelative(-1) },
    { key = '.', action = act.MoveTabRelative(1) },
    { key = 'Escape', action = 'PopKeyTable' },
  },
  search = {
    { key = 'Escape', action = 'PopKeyTable' },
  },
  pane = {
    { key = 'h', action = act.ActivatePaneDirection 'Left' },
    { key = 'j', action = act.ActivatePaneDirection 'Down' },
    { key = 'k', action = act.ActivatePaneDirection 'Up' },
    { key = 'l', action = act.ActivatePaneDirection 'Right' },
    { key = 'n', action = act.Multiple { 
        act.SplitPane {
          direction = 'Right',
          size = { Percent = 50 },
        },
        'PopKeyTable'
    }},
    { key = 'x', action = act.Multiple { 
        act.CloseCurrentPane{ confirm = false },
        'PopKeyTable'
    }},
    { key = 'Escape', action = 'PopKeyTable' },
  },
  find = {
    { key = 'c', action = wezterm.action.ActivateCommandPalette },
  },
}

for i = 0, 9 do
  table.insert(config.key_tables.tab, {
    key = tostring(i),
    action = act.ActivateTab(i),
  })
end

return config
