{ pkgs, nixpkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.grub = rec {
    enable = true;
    device = "/dev/sda"; 
    useOSProber = true; 
    gfxmodeBios = "1920x1080";
    theme = pkgs.fetchFromGitHub {
      owner = "dracula";
      repo = "grub";
      rev = "ad5b6bd4b159fea4950918a5510864ebb551519d";
      sha256 = "12c76qs6p0fpbn4c3i0va5ibr711fgdhhh4ci86hmd5ss93p4b5y";
    } + "/dracula";
    splashImage = theme + "/background.png";
  };

  time.timeZone = "America/New_York";

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    useDHCP = false;
    interfaces = {
      enp3s0.useDHCP = true;
      wlp4s0.useDHCP = true;
    };
  };

  hardware = {
    pulseaudio.support32Bit = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  virtualisation.libvirtd.enable = true;

  zramSwap.enable = true;

  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
    displayManager = {
      lightdm.enable = true;
      autoLogin = {
        enable = true;
        user = "mark";
      };
    };
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
    alsa = {
      enable = true;
      support32Bit = true;
    };
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
        "libvirtd"
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
      extraConfig = "Defaults env_reset,pwfeedback";
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
      gnumake
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
    registry.nixpkgs.flake = nixpkgs;
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

