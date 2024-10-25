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
    {
        key = 'y',
        mods = 'ALT',
        action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' },
    },
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

    if is_work then
        local tab, pane_shell, window_pps = mux.spawn_window({
            workspace = "pps",
            cwd = "C:\\Users\\U681181\\coding\\pps",
        })
        tab:set_title "shell"
        local tab, pane_code, window = window_pps:spawn_tab {}
        tab:set_title "code"
        mux.set_active_workspace("pps")
        wezterm.sleep_ms(100)
        pane_shell:split { size = split_ratio, direction = "Left" }
        local pane = pane_code:split { 
            size = split_ratio,
            cwd = "C:\\Users\\U681181\\coding\\pps\\js\\lib\\helium-js",
            direction = "Left",
        }
        pane:send_text 'rollup -c -w\r\n'
        pane_code:send_text 'nvim\r\n'
        pane_shell:activate()
        pane_code:activate()

        local tab, pane_shell, window_vawa = mux.spawn_window({ 
            workspace = "vawa",
            cwd = "C:\\Users\\U681181\\coding\\vawa",
        })
        local tab, pane_code, window = window_vawa:spawn_tab {}
        tab:set_title "code"
        mux.set_active_workspace("vawa")
        wezterm.sleep_ms(100)
        pane_shell:activate()
        pane_shell:split { size = split_ratio, direction = "Left" }
        pane_code:split { 
            size = split_ratio,
            cwd = "C:\\Users\\U681181\\coding\\vawa",
            direction = "Left",
        }
        pane_code:send_text 'nvim\r\n'
        pane_shell:activate()
        pane_code:activate()

        mux.set_active_workspace(workspace)
    end
end)

return config
