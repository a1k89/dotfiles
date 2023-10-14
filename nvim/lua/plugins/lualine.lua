local setup, lualine = pcall(require, "lualine")
if not setup then return end

local colors = {
  blue   = '#80a0ff',
  cyan   = '#E9AEFE',
  black  = '#080808',
  white  = '#FFFFFF',
  red    = '#ff5189',
  violet = '#d183e8',
  grey   = '#303030',
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.violet },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.black, bg = colors.black },
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.black, bg = colors.black },
  },
}
local function clock()
	return " " .. os.date("%H:%M")
end

local function holidays()
	return "🎅🎄🌟🎁"
end

local function my_favs()
	return "🦄🐙"
end

lualine.setup {
  options = {
    theme = bubbles_theme,
    component_separators = '|',
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = { "mode" },
	lualine_b = { "branch"},
    lualine_c = { 'fileformat' },
	lualine_y = { "location" },
	lualine_z = { clock, my_favs },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
}
