{
  config,
  pkgs,
  user,
  ...
}: {
  # home-manager.users.${user}.home.file.".config/hypr/per-app/audio.conf" = {
  #   text = ''
  #     windowrule = float, pavucontrol
  #   '';
  # };
  users.users.${user}.packages = with pkgs; [pamixer pavucontrol];
  security.rtkit.enable = true;       # used by PulseAudio to acquire realtime priority
  #sound.enable = true;               # Not intended to be enabled with Pipewire. Disable to fix alsa-store.service failure on rebuild. See https://github.com/NixOS/nixpkgs/issues/319809
  services.pulseaudio.enable = false; # We will use the pipewire version instead, defined below

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    audio.enable = true;
    # jack.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
}