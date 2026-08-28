{
  # Image viewer. GNOME app, but it only needs GTK4 and a file-chooser portal,
  # both of which programs.niri already sets up in ../system/desktop.nix - no
  # GNOME session required.
  #
  # Linux-only in practice: do not list this app on the macbook.
  home =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ loupe ];
    };
}
