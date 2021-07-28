{ pkgs, lib, config, ... }:

{
  services.polybar = rec {
    enable = true;
    package = pkgs.polybar.override {
      i3GapsSupport = true;
      pulseSupport = true;
    };
    script = "${package}/bin/polybar dracula &";
    settings = {
      "colors" = {
        background = {
          text = "#282a36";
          alt = "#282a36";
        };
        foreground = {
          text = "#f8f8f2";
          alt = "#f8f8f2";
        };
        primary = "#13f01e";
        secondary = "#bd93f9";
        alert = "#bd93f9";
      };
      "bar/dracula" = {
        monitor = "DisplayPort-2";
        height = 28;
        enable.ipc = true;
        background = "\${colors.background}";
        foreground = "\${colors.foreground}";
        line.size = 3;
        border = {
          color = "#44465a";
          bottom.size = 3;
        };
        padding = {
          left = 0;
          right = 2;
        };
        module.margin = {
          left = 1;
          right = 2;
        };
        font = [
          "Source Code Pro:pixelsize=12;1"
          "Font Awesome 5 Free Solid:size=11;1"
          "Font Awesome 5 Free Solid:size=10;1"
          "Font Awesome 5 Brands Regular:size=11;1"
        ];
        modules = {
          left = "i3";
          center = "date";
          right = "dunst xkeyboard pulseaudio powermenu";
        };
        cursor = {
          click = "pointer";
          scroll = "ns-resize";
        };
      };
      "module/dunst" = {
        type = "custom/ipc";
        initial = 1;
        hook = [
          "echo \"%{A1:${pkgs.dunst}/bin/dunstctl set-paused true && ${pkgs.polybar}/bin/polybar-msg hook dunst 2:}%{F#ff5555}%{F-} on%{A}\" &"
          "echo \"%{A1:${pkgs.dunst}/bin/dunstctl set-paused false && ${pkgs.polybar}/bin/polybar-msg hook dunst 1:}%{F#ff5555}%{F-} off%{A}\" &"
        ];
      };
      "module/xkeyboard" = {
        type = "internal/xkeyboard";
        blacklist = [ "num lock" ];
        format = {
          text = "<label-layout><label-indicator>";
          spacing = 0;
          prefix = {
            text = " ";
            foreground = "#ffb86c";
          };
        };
        label = {
          layout = "%layout%";
          indicator.on = " %name%";
        };
      };
      "module/i3" = {
        type = "internal/i3";
        format = "<label-state> <label-mode>";
        index.sort = true;
        wrapping.scroll = false;
        label = {
          mode = {
            padding = 2;
            foreground = "#000";
            background = "\${colors.primary}";
          };
          focused = {
            text = "%icon%";
            background = "\${colors.background-alt}";
            underline = "\${colors.secondary}";
            padding = 2;
          };
          unfocused = {
            text = "%icon%";
            padding = 2;
          };
          visible = {
            text = "%icon%";
            background = "\${self.label-focused-background}";
            underline = "\${self.label-focused-underline}";
            padding = "\${self.label-focused-padding}"; };
          urgent = {
            text = "%icon%";
            background = "\${colors.alert}";
            padding = 2;
          };
        };
        ws.icon = {
          text = [ "1;" "2;" "3;" "4;" "5;" ];
          default = "";
        };
      };
      "module/date" = {
        type = "internal/date";
        interval = 5;
        date = {
          text = "";
          alt = " %m/%d/%y";
        };
        time = {
          text = " %I:%M %P ";
          alt = " %I:%M %P";
        };
        format = {
          prefix.foreground = "\${colors.foreground-alt}";
          padding = 0.5;
        };
        label = "%date% %time%";
      };
      "module/pulseaudio" = {
        type = "internal/pulseaudio";
        format.volume = "<label-volume>";
        label = {
          volume = "%{F#f1fa8c}%{F-} %percentage%";
          muted = {
            text = "";
            foreground = "#44475a";
          };
        };
      };
      "module/powermenu" = {
        type = "custom/menu";
        expand.right = true;
        format.spacing = 1;
        label = {
          open = {
            text = "%{T3}";
            foreground = "#50fa7b";
          };
          close = {
            text = "%{T2}";
            foreground = "#50fa7b";
          };
          separator = {
            text = "|";
            foreground = "\${colors.foreground-alt}";
          };
        };
        menu = [
          [ 
            { text = "%{T3} "; exec = "menu-open-1"; }
            { text = "%{T3}"; exec = "menu-open-2"; }
          ]
          [
            { text = "%{T2}"; exec = "menu-open-0"; }
            { text = "%{T3} "; exec = "sudo ${pkgs.systemd}/bin/reboot now"; }
          ]
          [
            { text = "%{T3}"; exec = "sudo ${pkgs.systemd}/bin/poweroff"; }
            { text = "%{T2}"; exec = "menu-open-0"; }
          ]
        ];
      };
      "settings" = {
        screenchange.reload = true;
      };
      "wm" = {
        margin = {
          top = 5;
          bottom = 5;
        };
      };
    };
  };
  systemd.user.services.polybar.Service.Environment = lib.mkForce "PATH=${lib.makeBinPath [config.services.polybar.package pkgs.dbus]}:/run/wrappers/bin";
}
