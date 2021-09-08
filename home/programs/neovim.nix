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
      plenary-nvim
      popup-nvim
      vim-fugitive
      dracula-nvim
      nvim-web-devicons
      feline-nvim
      bufferline-nvim
      nvim-tree-lua
      nvim-treesitter
      vim-python-pep8-indent
      v-vim
      vim-nix
      haskell-vim
      nim-vim
      lexima-vim
      vim-closetag
      presence-nvim
      nvim-ts-rainbow
      nest-nvim
    ];
    extraConfig = let
      luaRequire = module: builtins.readFile (builtins.toString 
        ../dotfiles/neovim + "/${module}.lua");
      luaConfig = builtins.concatStringsSep "\n" (map luaRequire [
        "theming"
        "options"
        "keymaps"
        "utility"
        "statusline"
      ]);
    in ''
      lua << 
      ${luaConfig}
      
    '';
  };
}
