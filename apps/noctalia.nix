{
  # System-only. noctalia's module turns on system services and a binary
  # cache, neither of which a user-level config can do.
  system =
    { inputs, ... }:
    {
      imports = [ inputs.noctalia.nixosModules.default ];

      programs.noctalia = {
        enable = true;

        # Turns on NetworkManager, bluetooth, upower and a power-profile
        # service, which noctalia's wifi/bluetooth/battery/power widgets all
        # read from.
        recommendedServices.enable = true;
      };

      # Prebuilt noctalia, so the Qt app is not compiled from source. This only
      # takes effect once this config is active; see the note below for the
      # very first switch.
      nix.settings = {
        extra-substituters = [ "https://noctalia.cachix.org" ];
        extra-trusted-public-keys = [
          "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
        ];
      };

      # noctalia is launched by niri (spawn-at-startup "noctalia") and owns its
      # own theme at runtime, including the generated ~/.config/niri/noctalia.kdl
      # that config.kdl includes. Nothing here writes its config.
    };
}
