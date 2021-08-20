{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    (discord-plugged.override {
      themes = with inputs; [
        dracula-powercord
      ];
    })
  ];
}
