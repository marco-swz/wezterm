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
config.color_scheme = 'Night Owl (Gogh)'
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
--config.font = wezterm.font("Hack Nerd Font Mono", {weight="Regular", stretch="Normal", style="Normal"})
config.audible_bell = 'Disabled'
config.font_size = 11
config.tab_bar_at_bottom = false
config.keys = {
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
    { key = 's', mods = 'ALT', action = act.ActivateTab(0) },
    { key = 'd', mods = 'ALT', action = act.ActivateTab(1) },
    { key = 'f', mods = 'ALT', action = act.ActivateTab(2) },
    { key = 'f', mods = 'ALT', action = act.ActivateTab(3) },
    { key = 'i', mods = 'ALT', action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 'u', mods = 'ALT', action = act.SplitPane {
        direction = 'Right',
        size = { Percent = 50 },
    }},
    { key = 'q', mods = 'ALT', action = act.CloseCurrentTab { confirm = false } },
}

return config
