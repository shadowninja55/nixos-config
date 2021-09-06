{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "dracula";
        src = pkgs.fetchFromGitHub {
          owner = "dracula";
          repo = "fish";
          rev = "28db361b55bb49dbfd7a679ebec9140be8c2d593";
          sha256 = "07kz44ln75n4r04wyks1838nhmhr7jqmsc1rh7am7glq9ja9inmx";
        };
      }
    ];
    shellAliases = {
      ssh = "kitty +kitten ssh";
      ls = "${pkgs.exa}/bin/exa";
      grep = "${pkgs.ripgrep}/bin/rg";
      cd = "z";
      aplkb = "setxkbmap -layout us,apl -option grp:switch";
      eskb = "setxkbmap -layout us,es -option grp:shift_caps_toggle";
    };
    shellInit = ''
      set fish_greeting
    '';
  };
}
