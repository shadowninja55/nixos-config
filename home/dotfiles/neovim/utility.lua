-- lsp
local lspc = require 'lspconfig'
lspc.pyright.setup {}
lspc.rnix.setup {}
lspc.cssls.setup {
  cmd = {'css-languageserver', '--stdio'}
}
lspc.tsserver.setup {}
lspc.rust_analyzer.setup {}
lspc.vls.setup {
  cmd = {'/home/mark/.vls/cmd/vls/vls'}
}
lspc.sumneko_lua.setup {
  cmd = {'lua-language-server'}
}
lspc.hls.setup {}
lspc.nimls.setup {}

-- lsp icons
require('lspkind').init {
  with_text = false
}

-- compe
require('compe').setup {
  enabled = true;
  autocomplete = true;
  source = {
    buffer = true;
    nvim_lsp = true;
  };
}

-- lsp signature
require('lsp_signature').setup {
  bind = true,
  hint_enable = false,
  hi_parameter = 'Visual',
  handler_opts = {
    border = 'single'
  }
}

-- bufferline
require('bufferline').setup {
  options = {
    show_close_icon = false,
    show_buffer_close_icons = false,
    offsets = {{
      filetype = 'NvimTree',
      text = 'File Explorer',
      text_align = 'center'
    }}
  }
}
-- tree sitter
require('nvim-treesitter.configs').setup {
  ensure_installed = {"bash", "c", "css", "javascript", "json", "lua", "nix", "python", "rust", "toml"},
  highlight = {
    enable = true,
    disable = {"css"}
  },
  rainbow = {
    enable = true,
    disable = {"html"},
    extended_mode = true,
    max_file_lines = 10000,
    colors = {"#bd93f9", "#6272a4", "#8be9fd", "#50fa7b", "#f1fa8c", "#ffb86c", "#ff5555"}
  }
}

-- lexima
vim.fn['lexima#set_default_rules']()

-- file runners
vim.cmd 'autocmd FileType python nmap <F5> <Esc>:w<CR>:!python %<CR>'
vim.cmd 'autocmd FileType vlang nmap <F5> <Esc>:w<CR>:!v run %<CR>'
vim.cmd 'autocmd FileType fish nmap <F5> <Esc>:w<CR>:!fish %<CR>'
vim.cmd 'autocmd FileType nim nmap <F5> <Esc>:w<CR>:!nim r %<CR>'
vim.cmd 'autocmd BufEnter *.mys nmap <F5> <Esc>:w<CR>:!mys run<CR>'
vim.cmd 'autocmd FileType rust nmap <F5> <Esc>:w<CR>:!nix run<CR>'
vim.cmd 'autocmd FileType haskell nmap <F5> <Esc>:w<CR>:!cabal run<CR>'
vim.cmd 'autocmd FileType javascript nmap <F5> <Esc>:w<CR>:!node %<CR>'
