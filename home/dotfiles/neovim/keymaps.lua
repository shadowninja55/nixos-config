-- compe
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t '<C-p>'
  else
    return t '<S-Tab>'
  end
end

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t '<C-n>'
  elseif check_back_space() then
    return t '<Tab>'
  else
    return vim.fn['compe#complete']()
  end
end

-- nest
local nest = require 'nest'

nest.applyKeymaps {
  { '<a-', {
    { 'J>', '<cmd>BufferLineMoveNext<cr>' },
    { 'K>', '<cmd>BufferLineMovePrev<cr>' },
    { 'c>', '<cmd>bdelete!<cr>' },
    { 'j>', '<cmd>BufferLineCycleNext<cr>' },
    { 'k>', '<cmd>BufferLineCyclePrev<cr>' }
  }},
  { '<c', {
    { '-n>', '<cmd>NvimTreeToggle<cr>' },
    { '-t>', '<cmd>!kitty &<cr>' }
  }},
  { '<f2>', '<cmd>lua vim.lsp.buf.rename()<cr>' },
  { '<leader>', {
    { 'f', {
      { 'b', '<cmd>Telescope buffers<cr>' },
      { 'd', '<cmd>Telescope file_browser<cr>' },
      { 'f', '<cmd>Telescope find_files<cr>' }
    }}
  }},
  { 'K', '<cmd>lua vim.lsp.buf.hover()<cr>' },
  { '[e', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>' },
  { ']e', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>' },
  { 'g', {
    { 'd', '<cmd>lua vim.lsp.buf.definition()<cr>' },
    { 'y', '<cmd>lua vim.lsp.buf.type_definition()<cr>' }
  }},
  { 'qf', '<cmd>lua vim.lsp.buf.code_action()<CR>' },
  { mode = 'i', {
    { options = { expr = true }, {
      { '<cr>', "compe#confirm(lexima#expand('<LT>CR>', 'i'))" },
      { '<s-tab>', 'v:lua.s_tab_complete()' },
      { '<tab>', 'v:lua.tab_complete()' }
    }}
  }},
  { mode = 's', {
    { options = { expr = true }, {
      { '<s-tab>', 'v:lua.s_tab_complete()' },
      { '<tab>', 'v:lua.tab_complete()' }
    }}
  }},
  { mode = 'v', {
    { '<c-c>', '"+y' }
  }}
}
