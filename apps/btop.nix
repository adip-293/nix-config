{
  # Resource monitor. Installed as a bare package on purpose: home-manager's
  # programs.btop would make ~/.config/btop/btop.conf a read-only symlink into
  # the store, and btop's own in-app options menu could no longer write to it.
  home =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ btop ];
    };
}
