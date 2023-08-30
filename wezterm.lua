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
        key = 'd',
        mods = 'ALT',
        action = act.ActivateKeyTable {
            name = 'tab',
            one_shot = true,
        },
    },
    {
        key = 'f',
        mods = 'ALT',
        action = act.ActivateKeyTable {
            name = 'pane',
          one_shot = true,
        },
    },
    {
        key = 'a',
        mods = 'ALT',
        action = act.ActivateKeyTable {
            name = 'move',
            one_shot = false,
        },
    },
    {
        key = 'g',
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
        key = 'v',
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
    { key = 'h', mods = 'ALT|CTRL', action = act.AdjustPaneSize { 'Left', 3 } },
    { key = 'l', mods = 'ALT|CTRL', action = act.AdjustPaneSize { 'Right', 3 } },
    { key = 'k', mods = 'ALT|CTRL', action = act.AdjustPaneSize { 'Up', 3 } },
    { key = 'j', mods = 'ALT|CTRL', action = act.AdjustPaneSize { 'Down', 3 } },
    { key = 'q', mods = 'ALT', action = act.ActivateTab(0) },
    { key = 'w', mods = 'ALT', action = act.ActivateTab(1) },
    { key = 'e', mods = 'ALT', action = act.ActivateTab(2) },
    { key = 'r', mods = 'ALT', action = act.ActivateTab(3) },
    { key = 't', mods = 'ALT', action = act.ActivateTab(4) },
    { key = 'y', mods = 'ALT', action = act.ActivateTab(5) },
    { key = 'u', mods = 'ALT', action = act.ActivateTab(6) },
    { key = 'i', mods = 'ALT', action = act.ActivateTab(7) },
    { key = 'o', mods = 'ALT', action = act.ActivateTab(8) },
}
config.key_tables = {
    resize = {
        { key = 'LeftArrow', action = act.AdjustPaneSize { 'Left', 3 } },
        { key = 'h', action = act.AdjustPaneSize { 'Left', 3 } },

        { key = 'RightArrow', action = act.AdjustPaneSize { 'Right', 3 } },
        { key = 'l', action = act.AdjustPaneSize { 'Right', 3 } },

        { key = 'UpArrow', action = act.AdjustPaneSize { 'Up', 3 } },
        { key = 'k', action = act.AdjustPaneSize { 'Up', 3 } },

        { key = 'DownArrow', action = act.AdjustPaneSize { 'Down', 3 } },
        { key = 'j', action = act.AdjustPaneSize { 'Down', 3 } },

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

return config
