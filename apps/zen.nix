{
  # Zen is not in nixpkgs, so it comes from the zen-browser flake input
  # declared in ../flake.nix. `default` is the wrapped beta build. `inputs`
  # reaches this module because ../system/home-manager.nix passes it through as
  # an extraSpecialArg.
  #
  # Linux-only: the flake exposes x86_64-linux and aarch64-linux only, so the
  # macbook needs Zen from a cask and should not list this app.
  home =
    { pkgs, inputs, ... }:
    {
      home.packages = [
        inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };
}
