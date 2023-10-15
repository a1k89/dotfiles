local wezterm = require 'wezterm'


local config = {
    default_cursor_style = "BlinkingBlock",
    macos_window_background_blur = 30,
    enable_tab_bar = true,
    audible_bell = "Disabled",
    color_scheme = "Abernathy",
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
	font_size = 13,
    launch_menu = {},
	tab_bar_at_bottom = false,
	tab_max_width = 999, window_padding = { left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
    window_decorations = "TITLE",
    inactive_pane_hsb = {
		brightness = 0.9,
	},
}
local act = wezterm.action

config.leader = { key = 'o', mods = 'ALT', timeout_milliseconds = 1000 }
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
   
  { key = 'l', mods = 'ALT', action = wezterm.action.ShowLauncher },
  {
    key = '_',
    mods = 'LEADER',
    action =act.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = '|',
    mods = 'LEADER',
    action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },

  -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
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

}

return config

