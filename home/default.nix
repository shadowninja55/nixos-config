{ config, pkgs, ... }:

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
  ];
  programs.home-manager.enable = true;

  home.username = "mark";
  home.homeDirectory = "/home/mark";

  home = {
    stateVersion = "21.11";
    packages = with pkgs; [
      firefox
      discord
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
    ];
    sessionPath = [
      "$HOME/.local/bin"
    ];
    sessionVariables = {
      HOME_NIX = "$HOME/nixos/home/default.nix";
      SYS_NIX = "$HOME/nixos/configuration.nix";
      PI = "192.168.0.198";
      VFLAGS = "-cc ${pkgs.tinycc}/bin/tcc -cflags -I ${pkgs.tinycc}/lib/tcc/include -I ${pkgs.glibc.dev}/include -I $HOME/.v/thirdparty/tcc/lib/tcc/include -L $HOME/.v/thirdparty/tcc/lib -ltcc -DCUSTOM_DEFINE_no_backtrace";
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

  programs.fish = {
    enable = true;
    # shellInit = "direnv hook fish | source";
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
