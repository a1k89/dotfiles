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

lualine.setup {
  options = {
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },   theme = bubbles_theme,
  },
  sections = {
    lualine_a = { "mode" },
	lualine_b = { "branch"},
    lualine_c = { 'fileformat' },
	lualine_y = { "location" },
    lualine_x = {
      { 'diagnostics', 
                sources = { "nvim_diagnostic" }, 
                symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' } },
      'encoding',
      'filetype'
    },
	lualine_z = { clock,},
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
