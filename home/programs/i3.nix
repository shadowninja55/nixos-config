{ pkgs, lib, ... }:

{
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod4";
      terminal = "${pkgs.kitty}/bin/kitty";
      menu = "\"${pkgs.rofi}/bin/rofi -modi drun -show drun\"";
      bars = [ ];
      keybindings = let mod = "Mod4"; in lib.mkOptionDefault {
        "${mod}+c" = "kill";
        "${mod}+p" = "exec ${pkgs.maim}/bin/maim -suq | ${pkgs.xclip}/bin/xclip -selection clipboard -t image/png";
        "${mod}+Shift+p" = "exec ${pkgs.maim}/bin/maim -uq | ${pkgs.xclip}/bin/xclip -selection clipboard -t image/png";
        "${mod}+Shift+f" = "floating toggle";
        "XF86AudioRaiseVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5% && $refresh_i3status";
        "XF86AudioLowerVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5% && $refresh_i3status";
        "XF86AudioMute" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle && $refresh_i3status";
        "${mod}+Ctrl+Left" = "workspace prev";
        "${mod}+Ctrl+Right" = "workspace next";
        "Mod1+Tab" = "workspace back_and_forth";
      };
      assigns = {
        "1" = [{ class = "Firefox"; }];
        "3" = [{ class = "discord"; }];
        "5" = [{ class = "Steam"; }];
      };
      window.commands = [
        { command = "border pixel 3"; criteria = { class = ".*"; }; }
      ];
      colors = let repeatColor = color: {
        border = color;
        background = color;
        text = color;
        childBorder = color;
        indicator = color;
      }; in rec {
        focused = repeatColor "#bbbbbb";
        focusedInactive = repeatColor "#44475a";
        urgent = repeatColor "#bd93f9";
        unfocused = focusedInactive;
      };
      gaps = {
        inner = 10;
        outer = 0;
      };
      fonts.size = 2.0;
      defaultWorkspace = "workspace number 1";
      startup = [
        {
          command = "${pkgs.systemd}/bin/systemctl --user restart polybar";
          notification = false;
        }
      ];
      focus.newWindow = "focus";
    };
  };
}
