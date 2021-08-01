{ ... }:

{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        geometry = "0x4-25+25";
        padding = 8;
        horizontal_padding = 10;
        frame_width = 3;
        separator_height = 3;
        frame_color = "#44475a";
        font = "Monospace 10";
        format = "%s %p\\n%b";
        word_wrap = true;
        max_icon_size = 64;
        markup = "full";
        ignore_newline = false;
        mouse_left_click = "do_action, close_current";
        stack_duplicates = false;
      };
      urgency_low = {
        background = "#282a36";
        foreground = "#6272a4";
        timeout = 10;
      };
      urgency_normal = {
        background = "#282a36";
        foreground = "#bd93f9";
        timeout = 10;
      };
      urgency_critical = {
        background = "#ff5555";
        foreground = "#f8f8f2";
        timeout = 0;
      };
    };
  };
}
