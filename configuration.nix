{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda"; 
    useOSProber = true;
  };

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";

  networking.useDHCP = false;
  networking.interfaces.enp3s0.useDHCP = true;
  networking.interfaces.wlp4s0.useDHCP = true;

  hardware = {
    pulseaudio.support32Bit = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
    displayManager.lightdm.enable = true;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [
        rofi
      	polybar
        picom
        dunst
        libnotify
        xclip
        maim
        feh
        lxappearance
      ];
    };
    libinput = {
      enable = true;
      mouse.middleEmulation = false;
    };
    config = ''
      Section "InputClass"
        Identifier "mouse accel"
        Driver "libinput"
        MatchIsPointer "on"
        Option "AccelProfile" "flat"
        Option "AccelSpeed" "0"
      EndSection
    '';
    layout = "us,es";
    xkbOptions = "grp:win_win_space_toggle";
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users = {
    groups.power = {};
    users.mark = {
      isNormalUser = true;
      extraGroups = [ 
        "wheel"
        "networkmanager"
        "power"
      ];
      shell = pkgs.fish;
    };
  };

  services.gnome.gnome-keyring.enable = true;

  security = {
    rtkit.enable = true;
    sudo = {
      enable = true;
      extraRules = [{
        groups = [ "power" ];
        commands = [
          {
            command = "${pkgs.systemd}/bin/poweroff";
            options = [ "NOPASSWD" ];
          }
          {
            command = "${pkgs.systemd}/bin/reboot";
            options = [ "NOPASSWD" ];
          }
        ];
      }];
    };
    pam.services.lightdm.enableGnomeKeyring = true;
    polkit.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      fish
      direnv
      neovim
      git
      kitty
      gcc
      glibc
      glibc.dev
      gnumake
      patchelf
      polkit
    ];
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  nixpkgs.config.allowUnfree = true;
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  programs = {
    steam.enable = true;
    dconf.enable = true;
  };

  system.stateVersion = "21.05";
  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "SourceCodePro" ]; })
      font-awesome
      source-code-pro
      noto-fonts-cjk
      noto-fonts-emoji
    ];
    fontconfig = {
      defaultFonts = {
        monospace = [ "Source Code Pro" ];
        sansSerif = [ "DejaVu Sans" "Noto Color Emoji" ];
      };
    };
  };
}

