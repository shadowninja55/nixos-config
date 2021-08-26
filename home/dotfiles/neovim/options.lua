local o = vim.opt
local g = vim.g

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

o.number = true
o.relativenumber = true
o.showmode = false
o.hidden = true
g.nvim_tree_hide_dotfiles = 1
g.v_autofmt_bufwritepre = 0
g.python_highlight_all = 1
g.python_recommended_style = 0
g.rust_recommended_style = 0
g.mapleader = ' '
g.lexima_no_default_rules = 1

vim.cmd 'filetype plugin indent on'
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.completeopt = 'menuone,noselect'
o.shortmess = o.shortmess + 'c'
