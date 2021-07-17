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
  ];
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "mark";
  home.homeDirectory = "/home/mark";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
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
      HOME_NIX = "$HOME/.config/nixpkgs/home.nix";
      SYS_NIX = "/etc/nixos/configuration.nix";
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
    shellInit = "direnv hook fish | source";
  };
}
