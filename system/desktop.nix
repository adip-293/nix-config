{ pkgs, ... }:
{
  # The compositor. Its user config is hand-edited at ~/.config/niri/config.kdl
  # and is deliberately not managed by Nix for now.
  programs.niri.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [ wl-clipboard ];
}
