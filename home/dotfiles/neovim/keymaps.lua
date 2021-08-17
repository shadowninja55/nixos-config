local map = vim.api.nvim_set_keymap

map('v', '<C-c>', '"+y', {}) -- copy
map('n', '<C-t>', ':silent !kitty &<CR>', {}) -- spawn term

-- compe
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
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

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t '<C-p>'
  else
    return t '<S-Tab>'
  end
end

map('i', '<Tab>', 'v:lua.tab_complete()', {expr = true})
map('i', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})
map('s', '<Tab>', 'v:lua.tab_complete()', {expr = true})
map('s', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})

-- lsp
local lsp_opts = {noremap = true, silent = true}
map('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', lsp_opts)
map('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', lsp_opts)
map('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', lsp_opts)
map('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', lsp_opts)
map('n', 'qf', '<cmd>lua vim.lsp.buf.code_action()<CR>', lsp_opts)
map('n', '[e', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', lsp_opts)
map('n', ']e', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', lsp_opts)

-- bufferline
map('n', '<A-k>', ':BufferLineCyclePrev<CR>', {silent = true})
map('n', '<A-j>', ':BufferLineCycleNext<CR>', {silent = true})
map('n', '<A-K>', ':BufferLineMovePrev<CR>', {silent = true})
map('n', '<A-J>', ':BufferLineMoveNext<CR>', {silent = true})
map('n', '<A-c>', ':bdelete!<CR>', {silent = true})

-- filetree
map('n', '<C-n>', ':NvimTreeToggle<CR>', {})

-- telescope
map('n', '<leader>ff', ':Telescope find_files<CR>', {})
map('n', '<leader>fd', ':Telescope file_browser<CR>', {})
map('n', '<leader>fb', ':Telescope buffers<CR>', {})

-- lexima
vim.g.lexima_no_default_rules = 1
local lexima_opts = {expr = true, silent = true, noremap = true}
vim.fn['lexima#set_default_rules']()
map('i', '<C-Space>', 'compe#complete()', lexima_opts)
map('i', '<CR>', 'compe#confirm(lexima#expand("<LT>CR>", "i"))', lexima_opts)
map('i', '<C-e>', 'compe#close("<C-e>")', lexima_opts)
map('i', '<C-f>', 'compe#scroll({"delta": +4})', lexima_opts)
map('i', '<C-d>', 'compe#scroll({"delta": -4})', lexima_opts)
