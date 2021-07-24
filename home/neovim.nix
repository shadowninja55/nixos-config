{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = let dracula-nvim = pkgs.vimUtils.buildVimPlugin {
      name = "dracula.nvim";
      src = pkgs.fetchFromGitHub { owner = "Mofiqul";
        repo = "dracula.nvim";
        rev = "2f98ce06c359fa3f9c34d274615b3f269f89e55c";
        sha256 = "1grnkar29hydq3idmd3w1v3bsac9byj467fdygmi01khp2klqgv6";
      };
    }; in let v-vim = pkgs.vimUtils.buildVimPlugin {
      name = "v-vim";
      src = pkgs.fetchFromGitHub {
        owner = "ollykel";
        repo = "v-vim";
        rev = "f7f3a9a8402ae7276df2e4bc8b3bad62d16874b5";
        sha256 = "1g546nwz8inwgxns2lc5171lrpar68x89cbc94vs7k8vxnd11wxa";
      };
    }; in with pkgs.vimPlugins; [
      nvim-lspconfig
      lspkind-nvim
      nvim-compe
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
      
    '';
  };
}
