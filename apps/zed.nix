{
  # Editor. The binary is `zeditor`, not `zed`. Bound to Super+X in
  # ~/.config/niri/config.kdl.
  #
  # Installed as a bare package rather than through programs.zed-editor, which
  # would take ownership of ~/.config/zed/settings.json and replace the
  # hand-edited one.
  home =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ zed-editor ];
    };
}
