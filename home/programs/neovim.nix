{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      lspkind-nvim
      nvim-compe
      lsp_signature-nvim
      telescope-nvim
      telescope-fzy-native-nvim
      plenary-nvim
      popup-nvim
      vim-fugitive
      dracula-nvim
      nvim-web-devicons
      feline-nvim
      nvim-bufferline-lua
      nvim-tree-lua
      nvim-treesitter
      nim-vim
      vim-python-pep8-indent
      v-vim
      vim-nix
      i3config-vim
      purescript-vim
      haskell-vim
      lexima-vim
      vim-closetag
      presence-nvim
      nvim-ts-rainbow
    ];
    extraConfig = ''
      lua << 
      require "theming"
      require "options"
      require "keymaps"
      require "utility"
      require "statusline"
      
    '';
  };
}
