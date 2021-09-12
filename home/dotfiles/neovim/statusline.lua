local components = {
  active = {{}, {}, {}},
  inactive = {{}, {}}
}

local colors = {
  fg = '#282a36', -- '#f8f8f2',
  bg = '#44475a',
  skyblue = '#8be9fd',
  cyan = '#8be9fd',
  green = '#50fa7b',
  oceanblue = '#6272a4',
  magenta = '#ff79c6',
  orange = '#ffb86c',
  red = '#ff5555',
  violet = '#bd93f9',
  white = '#f8f8f2',
  yellow = '#f1fa8c'
}

local vi_mode_text = {
  n = "NORMAL",
  i = "INSERT",
  v = "VISUAL",
  [''] = "V-BLOCK",
  V = "V-LINE",
  c = "COMMAND",
  R = "REPLACE",
  r = "REPLACE",
  t = "INSERT"
}

local vi_mode_utils = require('feline.providers.vi_mode')

table.insert(components.active[1], {
  provider = function()
    local mode = vi_mode_text[vim.fn.mode()]
    mode = mode and mode or 'UNKNOWN'
    return ' ' .. mode .. ' '
  end,
  hl = function()
  return {
    name = vi_mode_utils.get_mode_highlight_name(),
    fg = colors.fg,
    bg = colors.red,
    style = 'bold'
  }
  end,
  right_sep = 'slant_right',
})

table.insert(components.active[1], {
  provider = 'file_info',
  hl = {
    fg = colors.fg,
    bg = colors.orange,
    style = 'bold'
  },
  left_sep = {
    'slant_left_2',
    {str = ' ', hl = {bg = colors.orange}}
  },
  right_sep = 'slant_right'
})


table.insert(components.active[3], {
  provider = 'line_percentage',
  hl = {
    fg = colors.fg,
    bg = colors.yellow,
    style = 'bold'
  },
  left_sep = {
    'slant_left',
    {str = ' ', hl = {bg = colors.yellow}},
  },
  right_sep = {
    {str = ' ', hl = {bg = colors.yellow}},
    'slant_right_2'
  }
})

table.insert(components.active[3], {
  provider = 'position',
  hl = {
    fg = colors.fg,
    bg = colors.green,
    style = 'bold'
  },
  left_sep = {
    'slant_left',
    {str = ' ', hl = {bg = colors.green}}
  },
  right_sep = {str = ' ', hl = {bg = colors.green}}
})

require('feline').setup {
  default_bg = colors.bg,
  default_fg = colors.fg,
  colors = colors,
  components = components
}
