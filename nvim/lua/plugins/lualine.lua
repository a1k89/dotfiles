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

lualine.setup {
  options = {
    icons_enable = true,
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },   
    theme = bubbles_theme,
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 500,
      tabline = 500,
      winbar = 500,
    }
},
  sections = {
    lualine_a = { "mode" },
	lualine_b = { "branch", "diff", },
    lualine_c = {{"filename", path = 3}, "filesize"},    
    lualine_x = {
      { 'diagnostics', 
                sources = { "nvim_diagnostic" }, 
                symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' } },
      'encoding',
      'filetype',
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {"filename"},
    lualine_x = {"location"},   
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {
        "fugitive",
        "trouble",
        "lazy",
        "oil",
        "quickfix",
    },
}
