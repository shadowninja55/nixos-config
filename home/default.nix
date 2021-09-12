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
    ./programs/powercord.nix
    ./programs/starship.nix
    ./programs/zoxide.nix
  ];
  programs.home-manager.enable = true;

  home = {
    username = "mark";
    homeDirectory = "/home/mark";
    stateVersion = "21.11";
    packages = with pkgs; [
      firefox
      element-desktop
      steam
      lunar-client
      gnome.seahorse
      bitwarden
      mpv
      virt-manager
      obs-studio
      godot
      bluej

      gh
      ranger
      tldr
      spotify-tui
      bottom
      nix-prefetch-scripts
      xboxdrv
      zathura
      watson
      dyalog
      neofetch

      pulseaudio
      pyright
      rnix-lsp
      nodePackages.vscode-css-languageserver-bin
      nodePackages.typescript-language-server
      haskell-language-server
      rust-analyzer
      sumneko-lua-language-server
      nimlsp
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
