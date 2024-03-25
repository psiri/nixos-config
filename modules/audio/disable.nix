{
  config,
  pkgs,
  user,
  ...
}: {
  security.rtkit.enable = false;
  sound.enable = false;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = false;
    wireplumber.enable = false;
    alsa.enable = false;
    alsa.support32Bit = false;
    pulse.enable = false;
  };
}