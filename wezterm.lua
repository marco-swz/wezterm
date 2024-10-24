local wezterm = require 'wezterm'
local act = wezterm.action
local mux = wezterm.mux

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    config.default_prog = { 'powershell', '-NoLogo' }
end

config.launch_menu = launch_menu
--config.color_scheme = 'Night Owl (Gogh)
--config.color_scheme = 'Grayscale Dark (base16)'
--config.color_scheme = 'Deafened (terminal.sexy)'
config.color_scheme = 'Kanagawa (Gogh)'

config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.audible_bell = 'Disabled'
config.font_size = 13
config.tab_bar_at_bottom = false
--config.freetype_load_target = "Light"
config.font = wezterm.font {
    --family = 'Terminess Nerd Font',
    --family = 'Mononoki Nerd Font',
    --family = 'Hack Nerd Font',
    family = 'Consolas',
}
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
    --{ key = 'Backspace', mods = 'CTRL', action = act.SendKey {key = 'w', mods = 'CTRL'} },
    { key = 'u', mods = 'ALT', action = wezterm.action_callback(function(win, pane)
        local right_pane = pane:tab():get_pane_direction('Right')
        local left_pane = pane:tab():get_pane_direction('Left')
        if right_pane == nil and left_pane == nil then
            pane:split {
                direction = 'Left',
                size = 0.35,
            }
        elseif right_pane == nil then
            left_pane:split {
                direction = 'Bottom',
                size = 0.5,
            }
        else
            pane:split {
                direction = 'Bottom',
                size = 0.5,
            }
        end
    end)},
    { key = 'q', mods = 'ALT', action = act.CloseCurrentPane { confirm = false } },
}

wezterm.on('gui-startup', function(cmd)
    local tab, pane, window = mux.spawn_window(cmd or {})
    pane:split { size = 0.85 }
    local tab, pane, window = window:spawn_tab {}
    pane:split { size = 0.85 }
    window:gui_window():maximize()
end)

return config
