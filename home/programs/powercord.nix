{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    (discord-plugged.override {
      discord-canary = discord-canary.override rec {
        version = "0.0.130";
        src = builtins.fetchTarball {
          url = "https://dl-canary.discordapp.net/apps/linux/${version}/discord-canary-${version}.tar.gz";
          sha256 = "0584mdas3bab50bihm40gvd7q553aid4hl8rnc932bxb1vv8isxy";
        };
      };
      themes = with inputs; [
        dracula-powercord
      ];
    })
  ];
}
