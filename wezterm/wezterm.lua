local wezterm = require 'wezterm'
local act = wezterm.action
local util = require("util")


local config = {
    enable_tab_bar = true,
    audible_bell = "Disabled",
    inactive_pane_hsb = {
        hue = 1.0,
        saturation = 1.0,
        brightness = 1.0,
    },
    colors = {
        cursor_bg = "#A6ACCD",
        cursor_border = "#A6ACCD",
        cursor_fg = "#1B1E28",
    },
    font = wezterm.font("JetBrains Mono", { weight = "Regular" }),
    font_size = 13.5,
    tab_bar_at_bottom = false,
    tab_max_width = 999,
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },
}

config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.status_update_interval = 100
config.tab_max_width = 70
config.tab_bar_at_bottom = false

wezterm.on("update-status", function(window, _)
    window:set_left_status(
        wezterm.format({
            { Attribute = { Intensity = "Bold" } },
            { Text = window:mux_window():get_workspace() },
            "ResetAttributes",
        })
    )
end)


config.leader = { key = 'o', mods = 'ALT', timeout_milliseconds = 500 }
config.keys = {
    {
        key = 'E',
        mods = 'LEADER',
        action = act.PromptInputLine {
            description = 'Enter new name for tab',
            action = wezterm.action_callback(function(window, pane, line)
                if line then
                    window:active_tab():set_title(line)
                end
            end),
        },
    },

    {
        key = '_',
        mods = 'LEADER',
        action = act.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
        key = '|',
        mods = 'LEADER',
        action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },

    {
        key = 'a',
        mods = 'LEADER|CTRL',
        action = act.SendKey { key = 'a', mods = 'CTRL' },
    },

    {
        key = "h",
        mods = "LEADER",
        action = act.ActivatePaneDirection("Left"),
    },
    {
        key = "j",
        mods = "LEADER",
        action = act.ActivatePaneDirection("Down"),
    },
    {
        key = "k",
        mods = "LEADER",
        action = act.ActivatePaneDirection("Up"),
    },
    {
        key = "l",
        mods = "LEADER",
        action = act.ActivatePaneDirection("Right"),
    },
    {
        key = "-",
        mods = "LEADER",
        action = act.ActivatePaneDirection("Right"),
    },
    {
        key = 'n',
        mods = 'LEADER',
        action = wezterm.action.ToggleFullScreen,
    },
    {
        key = "g",
        mods = "LEADER",
        action = wezterm.action_callback(function(window, pane)
            local workspaces = {
                { id = "/Users/andrey.koptev/Projects/mailman/",                                              label = "Mailman" },
                { id = "/Users/andrey.koptev/Projects/cuscom.transport/",                                     label = "Cuscom" },
                { id = "/Users/andrey.koptev/Projects/cuscom.transport.api/",                                 label = "Cuscom api" },
                { id = "/Users/andrey.koptev/Projects/jit",                                                   label = "Jit" },
                { id = "/Users/andrey.koptev/Projects/looney_letters/",                                       label = "Looney" },
                { id = "/Users/andrey.koptev/Projects/deploy/",                                               label = "Deploy config" },
                { id = "/Users/andrey.koptev/Projects/helm/",                                                 label = "Helm config" },
                { id = "/Users/andrey.koptev/Projects/rest/",                                                 label = "Rest" },
                { id = "/Users/andrey.koptev/Projects/education/",                                            label = "Education" },
                { id = "/Users/andrey.koptev/.config",                                                        label = "Dotfiles" },
                { id = "/Users/andrey.koptev/",                                                               label = "Kubectl" },
                { id = "/Users/andrey.koptev/Projects/leos.bob/",                                             label = "Leos.bob" },
                { id = "/Users/andrey.koptev/Projects/feedgenerator/",                                        label = "Feedgenerator" },
                { id = "/Users/andrey.koptev/Projects/marketing.endpoint/",                                   label = "Markeing endpoint" },
                { id = '/Users/andrey.koptev/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/GradeUp/', label = "Obsidian" },
                { id = '/Users/andrey.koptev/Projects/matryoshka/',                                           label = "Matryoshka" },
                { id = '/Users/andrey.koptev/Projects/seoapi/',                                               label = "SEO api" },
                { id = '/Users/andrey.koptev/Projects/madmin/',                                               label = "Madmin" },
                { id = '/Users/andrey.koptev/Projects/mobile.api.server/',                                    label = "Mobile API" },
            }
            window:perform_action(
                act.InputSelector {
                    action = wezterm.action_callback(function(window, pane, id, label)
                        if not id and not label then
                            wezterm.log_info "cancelled"
                        else
                            window:perform_action(
                                act.SwitchToWorkspace {
                                    name = label,
                                    spawn = {
                                        cwd = id,
                                    },
                                },
                                pane
                            )
                        end
                    end),
                    fuzzy = true,
                    title = "Jump to project",
                    choices = workspaces,
                    fuzzy_description = 'Project: ',
                },
                pane
            )
        end),
    },
}

return config
