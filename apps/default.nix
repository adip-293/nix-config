# The app store.
#
# Every app is exactly one file in this folder: apps/<name>.nix. A host turns
# an app on by listing its name in hosts/<host>/default.nix, and gets the
# package and its config together. Because there is only ever one file per app,
# editing it on one machine changes it on all of them after a `git pull` -
# which is the entire point of the layout.
#
# An app file is an attribute set with either or both of these keys:
#
#   system = { pkgs, ... }: { ... };   # runs as root, affects the whole
#                                      # machine (a NixOS or nix-darwin module)
#
#   home   = { pkgs, ... }: { ... };   # runs as pabio, owns files under ~
#                                      # (a home-manager module)
#
# Most apps need only `home` - that is the half that follows you between
# machines. Reach for `system` when the app genuinely needs root: a systemd
# service, a machine-wide package allowance, a shell listed in /etc/shells.
# An app can have both; zsh.nix does.
#
# This file exists so a host never has to know which half an app used. It takes
# the host's list of names and returns one module that wires both halves up.

names:

let
  # Deliberately not a directory listing: the host's list is the source of
  # truth, so a typo fails loudly instead of quietly installing nothing.
  apps = map (name: import (./. + "/${name}.nix")) names;

  halfOf = key: builtins.filter (m: m != null) (map (app: app.${key} or null) apps);
in
{
  # The system halves are imported as ordinary modules of the host.
  imports = halfOf "system";

  # The home halves are handed to home-manager instead. Same list of apps, two
  # destinations, decided per app rather than per host.
  home-manager.users.pabio.imports = halfOf "home";
}
