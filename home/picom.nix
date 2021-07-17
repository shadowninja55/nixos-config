{ ... }:

{
  services.picom = {
    enable = true;
    fade = true;
    shadow = true;
    shadowOffsets = [ (-7) (-7) ];
    noDockShadow = false;
    fadeSteps = [ "0.03" "0.03" ];
    fadeDelta = 8;
    vSync = true;
    extraOptions = "shadow-radius = 7;";
  };
}
