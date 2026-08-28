{
  # System-only. permittedInsecurePackages is a machine-wide nixpkgs setting
  # that only root can make, so the package it unlocks has to be installed on
  # the same side of the fence.
  system =
    { pkgs, ... }:
    {
      # Citrix's bundled ICA client still links libsoup2, which is EOL with
      # unpatched CVEs. Scoped to this one package; nothing else opts in.
      nixpkgs.config.permittedInsecurePackages = [ "libsoup-2.74.3" ];

      environment.systemPackages = with pkgs; [
        citrix_workspace

        # `wfica` (the ICA session viewer) is X11-only and niri is pure
        # Wayland, so Citrix does not launch without an X server bridged in.
        # Requires `xwayland-satellite :0` running and DISPLAY=:0 in the
        # session.
        xwayland-satellite
      ];

      # NOTE: the tarball is EULA-gated, so Nix cannot fetch it. On a new
      # machine:
      #   1. download linuxx64-<version>.tar.gz from citrix.com
      #   2. nix-prefetch-url file://$PWD/linuxx64-<version>.tar.gz
      # The version must match pkgs.citrix_workspace, currently 26.01.0.150.
    };
}
