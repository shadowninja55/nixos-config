{ pkgs, rnix-lsp-git, ... }:

{
  imports = [
    ./i3.nix
    ./polybar.nix
    ./dunst.nix
    ./picom.nix
    ./neovim.nix
    ./spotifyd.nix
    ./rofi.nix
    ./kitty.nix
    ./fish.nix
  ];
  programs.home-manager.enable = true;

  home.username = "mark";
  home.homeDirectory = "/home/mark";

  home = {
    stateVersion = "21.11";
    packages = with pkgs; [
      firefox
      discord
      element-desktop
      steam
      lunar-client
      gnome.seahorse
      bitwarden
      mpv
      anydesk

      gh
      ranger
      tldr
      spotify-tui
      bottom
      neofetch
      nix-prefetch-scripts

      pulseaudio
      pyright
      rnix-lsp-git
      nodePackages.vscode-html-languageserver-bin
      nodePackages.vscode-css-languageserver-bin
      nodePackages.typescript-language-server
      rust-analyzer
    ];
    sessionPath = [
      "$HOME/.local/bin"
    ];
    sessionVariables = {
      HOME_NIX = "$HOME/.config/nixos/home/default.nix";
      SYS_NIX = "$HOME/.config/nixos/system.nix";
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
      desktop = "~/desktop";
      download = "~/downloads";
      documents = "~/documents";
      videos = "~/videos";
      pictures = "~/pictures";
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
