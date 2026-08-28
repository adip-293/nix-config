{
  # Terminal file manager. On the Linux machines it is bound to Super+E in
  # ~/.config/niri/config.kdl, which opens it inside ghostty (`ghostty -e
  # yazi`). Nothing here depends on that, so it works unchanged on macOS.
  home =
    { ... }:
    {
      programs.yazi.enable = true;
    };
}
