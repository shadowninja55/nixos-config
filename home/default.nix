{ pkgs, ... }:

{
  imports = [
    ./programs/dunst.nix
    ./programs/fish.nix
    ./programs/i3.nix
    ./programs/kitty.nix
    ./programs/neovim.nix
    ./programs/picom.nix
    ./programs/polybar.nix
    ./programs/rofi.nix
    ./programs/spotifyd.nix
    ./programs/zathura.nix
  ];
  programs.home-manager.enable = true;

  home = {
    username = "mark";
    homeDirectory = "/home/mark";
    stateVersion = "21.11";
    packages = with pkgs; [
      firefox
      discord
      element-desktop
      steam
      lunar-client
      grapejuice
      gnome.seahorse
      bitwarden
      mpv
      virt-manager
      obs-studio

      gh
      ranger
      tldr
      spotify-tui
      bottom
      nix-prefetch-scripts
      xboxdrv
      exa
      zathura
      watson

      pulseaudio
      pyright
      rnix-lsp
      nodePackages.vscode-html-languageserver-bin
      nodePackages.vscode-css-languageserver-bin
      nodePackages.typescript-language-server
      nodePackages.purescript-language-server
      haskell-language-server
      rust-analyzer
      sumneko-lua-language-server
    ];
    sessionPath = [
      "$HOME/.local/bin"
    ];
    sessionVariables = {
      HOME_NIX = "$HOME/.config/nixos/home/default.nix";
      SYS_NIX = "$HOME/.config/nixos/system/default.nix";
      PI = "192.168.0.198";
    };
  };

  /* nixpkgs = {
    overlays = [(self: super: { discord-canary = super.discord-canary.overrideAttrs (_: { src = builtins.fetchTarball "https://discord.com/api/download/canary?platform=linux&format=tar.gz"; });})];
  }; */

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      desktop = "$HOME/desktop";
      download = "$HOME/downloads";
      documents = "$HOME/documents";
      videos = "$HOME/videos";
      pictures = "$HOME/pictures";
    };
  };

  xsession = {
    enable = true;
    initExtra = ''
      xrandr --output DisplayPort-2 --mode 1920x1080 --rate 143.98
      xset r rate 250 40
      feh --bg-scale $HOME/pictures/dracula.png
    '';
  };

  programs.git = {
    enable = true;
    userName = "shadowninja55";
    userEmail = "shadowninja1050@gmail.com";
  };

  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
    nix-direnv = {
      enable = true;
      enableFlakes = true;
    };
  };
}
