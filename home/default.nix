{ pkgs, ... }:

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
      pulseaudio
      gh
      steam
      ranger
      tldr
      spotify-tui
      gnome.seahorse
      bitwarden
      pyright
      rnix-lsp
      bottom
      neofetch
      lunar-client
      nix-prefetch-scripts
      mpv
    ];
    sessionPath = [
      "$HOME/.local/bin"
    ];
    sessionVariables = {
      HOME_NIX = toString ./home/default.nix;
      SYS_NIX = toString ./system.nix;
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
