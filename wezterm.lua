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
config.disable_default_key_bindings = true
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
    { key = 'h', mods = 'ALT|SHIFT', action = act.AdjustPaneSize { 'Left', 3 } },
    { key = 'l', mods = 'ALT|SHIFT', action = act.AdjustPaneSize { 'Right', 3 } },
    { key = 'k', mods = 'ALT|SHIFT', action = act.AdjustPaneSize { 'Up', 3 } },
    { key = 'j', mods = 'ALT|SHIFT', action = act.AdjustPaneSize { 'Down', 3 } },
    { key = 'u', mods = 'ALT', action = act.ActivateTab(0) },
    { key = 'i', mods = 'ALT', action = act.ActivateTab(1) },
    { key = 'o', mods = 'ALT', action = act.ActivateTab(2) },
    { key = 'p', mods = 'ALT', action = act.ActivateTab(3) },
    { key = 'n', mods = 'ALT', action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 'm', mods = 'ALT', action = wezterm.action_callback(function(win, pane)
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
    { key = 'n', mods = 'ALT|SHIFT', action = act.CloseCurrentTab { confirm = false } },
    { key = 'm', mods = 'ALT|SHIFT', action = act.CloseCurrentPane { confirm = false } },
    {
        key = 'y',
        mods = 'ALT',
        action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' },
    },
    {
        key = '\'',
        mods = 'ALT',
        action = act.ActivateKeyTable {
          name = 'locked',
          replace_current = true,
          one_shot = false,
        },
    },
    {
        key = 'y',
        mods = 'ALT|SHIFT',
        action = act.DetachDomain 'CurrentPaneDomain',
    },
}

config.key_tables = {
    locked = {
        {
            key = '\'',
            mods = 'ALT',
            action = act.PopKeyTable,
        },
        {
            key = 'h',
            mods = 'ALT',
            action = act.SendKey({ key = 'h', mods = 'ALT' }),
        },
        {
            key = 'l',
            mods = 'ALT',
            action = act.SendKey({ key = 'l', mods = 'ALT' }),
        },
        {
            key = 'j',
            mods = 'ALT',
            action = act.SendKey({ key = 'j', mods = 'ALT' }),
        },
        {
            key = 'k',
            mods = 'ALT',
            action = act.SendKey({ key = 'k', mods = 'ALT' }),
        },
        {
            key = ',',
            mods = 'ALT',
            action = act.SendKey({ key = ',', mods = 'ALT' }),
        },
        {
            key = '.',
            mods = 'ALT',
            action = act.SendKey({ key = '.', mods = 'ALT' }),
        },
        {
            key = '<',
            mods = 'ALT|SHIFT',
            action = act.SendKey({ key = '<', mods = 'ALT|SHIFT' }),
        },
        {
            key = '>',
            mods = 'ALT|SHIFT',
            action = act.SendKey({ key = '>', mods = 'ALT|SHIFT' }),
        },
        {
            key = 'h',
            mods = 'ALT|SHIFT',
            action = act.SendKey({ key = 'h', mods = 'ALT|SHIFT' }),
        },
        {
            key = 'l',
            mods = 'ALT|SHIFT',
            action = act.SendKey({ key = 'l', mods = 'ALT|SHIFT' }),
        },
        {
            key = 'k',
            mods = 'ALT',
            action = act.SendKey({ key = 'k', mods = 'ALT' })
        },
        {
            key = 'j',
            mods = 'ALT',
            action = act.SendKey({ key = 'j', mods = 'ALT' })
        },
        {
            key = 'u',
            mods = 'ALT',
            action = act.SendKey({ key = 'u', mods = 'ALT' })
        },
        {
            key = 'o',
            mods = 'ALT',
            action = act.SendKey({ key = 'o', mods = 'ALT' })
        },
        {
            key = 'i',
            mods = 'ALT',
            action = act.SendKey({ key = 'i', mods = 'ALT' })
        },
        {
            key = 'p',
            mods = 'ALT',
            action = act.SendKey({ key = 'p', mods = 'ALT' })
        },
        {
            key = 'n',
            mods = 'ALT',
            action = act.SendKey({ key = 'n', mods = 'ALT' }),
        },
        {
            key = 'n',
            mods = 'ALT|SHIFT',
            action = act.SendKey({ key = 'n', mods = 'ALT|SHIFT' }),
        },
        {
            key = 'm',
            mods = 'ALT',
            action = act.SendKey({ key = 'm', mods = 'ALT' }),
        },
        {
            key = 'm',
            mods = 'ALT|SHIFT',
            action = act.SendKey({ key = 'm', mods = 'ALT|SHIFT' }),
        },
        {
            key = 'y',
            mods = 'ALT',
            action = act.SendKey({ key = 'y', mods = 'ALT' }),
        },
        {
            key = 'y',
            mods = 'ALT|SHIFT',
            action = act.SendKey({ key = 'y', mods = 'ALT|SHIFT' }),
        },
    }
}

wezterm.on('update-right-status', function(window, pane)
    window:set_right_status(window:active_workspace())
end)

wezterm.on('gui-startup', function(cmd)
    local split_ratio = 0.3
    local is_work = false
    local workspace = nil
    if cmd then
        is_work = cmd.args[1] == "work"
        if is_work then
            workspace = cmd.args[2]
        end
    end

    local tab, pane_shell, window_coding = mux.spawn_window({workspace = "coding" })
    window_coding:gui_window():maximize()
    tab:set_title "shell"
    local tab, pane_code, window = window_coding:spawn_tab {}
    tab:set_title "code"
    mux.set_active_workspace("coding")
    wezterm.sleep_ms(100)
    pane_shell:split { size = split_ratio, direction = "Left" }
    pane_code:split { 
        size = split_ratio,
        direction = "Left",
    }
    pane_shell:activate()
    pane_code:activate()

end)

return config
