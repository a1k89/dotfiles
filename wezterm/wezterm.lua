local wezterm = require 'wezterm'
local act = wezterm.action

-- Functions
local get_last_folder_segment = function(cwd)
  if cwd == nil then
    return "N/A" -- or some default value you prefer
  end

  -- Strip off 'file:///' if present
  local pathStripped = cwd:match("^file:///(.+)") or cwd
  -- Normalize backslashes to slashes for Windows paths
  pathStripped = pathStripped:gsub("\\", "/")
  -- Split the path by '/'
  local path = {}
  for segment in string.gmatch(pathStripped, "[^/]+") do
    table.insert(path, segment)
  end
  return path[#path] -- returns the last segment
end

local function get_current_working_dir(tab)
  local current_dir = tab.active_pane.current_working_dir or ''
  return get_last_folder_segment(current_dir)
end

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
	tab_max_width = 999, window_padding = { left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
}

config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.status_update_interval = 1000
config.tab_max_width = 40
config.tab_bar_at_bottom = false

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local has_unseen_output = false
  local is_zoomed = false
  local index = tonumber( tab.tab_index )+1

  for _, pane in ipairs(tab.panes) do
    if not tab.is_active and pane.has_unseen_output then
      has_unseen_output = true
    end
    if pane.is_zoomed then
      is_zoomed = true
    end
  end

  local cwd = get_current_working_dir(tab)
  local zoom_icon = is_zoomed and wezterm.nerdfonts.cod_zoom_in or ""
  local title = string.format(' %s ~ %s %s ', index, cwd, zoom_icon) -- Add placeholder for zoom_icon

  return wezterm.format({
    { Attribute = { Intensity = 'Bold' } },
    { Text = title }
  })
end)

wezterm.on("update-right-status", function(window, pane)
  local workspace_or_leader = window:active_workspace()
  -- Change the worspace name status if leader is active
  if window:active_key_table() then workspace_or_leader = window:active_key_table() end
  if window:leader_is_active() then workspace_or_leader = "LEADER" end

  local cwd = pane:get_current_working_dir() or "N/A"
  local last_folder = get_last_folder_segment(cwd)
  local cmd = get_last_folder_segment(pane:get_foreground_process_name())
  local time = wezterm.strftime("%H:%M")
  local hostname = " " .. wezterm.hostname() .. " ";

  window:set_right_status(wezterm.format({
    { Text = wezterm.nerdfonts.oct_table .. " " .. workspace_or_leader },
    { Text = " | " },
    -- { Text = wezterm.nerdfonts.md_folder .. " " .. last_folder },
    -- { Text = " | " },
    { Foreground = { Color = "FFB86C" } },
    { Text = wezterm.nerdfonts.fa_code .. " " .. cmd },
    "ResetAttributes",
    { Text = " | " },
    { Text = wezterm.nerdfonts.oct_person .. " " .. hostname },
    { Text = " | " },
    { Text = wezterm.nerdfonts.md_clock .. " " .. time },
    { Text = " | " },
  }))
end)
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

