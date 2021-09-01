{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    (discord-plugged.override {
      discord-canary = discord-canary.override rec {
        version = "0.0.129";
        src = builtins.fetchTarball {
          url = "https://dl-canary.discordapp.net/apps/linux/${version}/discord-canary-${version}.tar.gz";
          sha256 = "1wsv8cd7jlj9ljcndk9h6jbvn64fhsw1qd44infif9yfw3nd5mz9";
        };
      };
      themes = with inputs; [
        dracula-powercord
      ];
    })
  ];
}
