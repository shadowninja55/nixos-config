{ pkgs, ... }:

{
  services.spotifyd = {
    enable = true;
    package = pkgs.spotifyd.override {
      withMpris = true;
      withKeyring = true;
    };
    settings = {
      global = {
        username = "j5grupppdv1j4gppqf8htbibf";
        use_keyring = true;
        backend = "alsa";
        device = "default";
        mixer = "PCM";
        volume-controller = "alsa";
        device_name = "spotifyd";
        device_type = "speaker";
        bitrate = 96;
        cache_path = ".cache/spotifyd";
        volume-normalisation = true;
        normalisation-pregain = -10;
        initial_volume = "51";
      };
    };
  };
}
