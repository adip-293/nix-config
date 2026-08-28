{ inputs, ... }:
{
  # Wires home-manager into this NixOS host. It manages everything that lives
  # under $HOME - dotfiles, shell config, per-app settings - which is the half
  # of a machine that should look identical on the thinkpad, the desktop and
  # (via nix-darwin) the macbook. System-level config stays in ../system and
  # ../apps.
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    # Build home config against the system's own pkgs, rather than letting
    # home-manager instantiate a second nixpkgs. One evaluation, one set of
    # overlays, and allowUnfree from ./core.nix applies to home packages too.
    useGlobalPkgs = true;

    # Put user packages in /etc/profiles/per-user/$USER instead of a separate
    # ~/.nix-profile. `nixos-rebuild switch` then applies the home config as
    # part of the system generation: no second `home-manager switch` step, and
    # rollbacks take the home config back with them.
    useUserPackages = true;

    # Flake inputs reach home/ modules the same way they reach system ones,
    # so ../home/apps/zen.nix can pull a package straight out of an input.
    extraSpecialArgs = { inherit inputs; };

    # The first switch aborts on any dotfile home-manager wants to write that
    # already exists by hand (a stray ~/.zshrc, say). This renames the old one
    # to <file>.hm-bak and carries on instead of failing the whole rebuild.
    backupFileExtension = "hm-bak";
  };

  # The baseline every app's home half is layered on top of. The apps
  # themselves are added here by ../apps/default.nix, from the list in
  # ../hosts/<host>/default.nix.
  home-manager.users.pabio = {
    # The home-manager release this home was first built with. Do not bump it
    # to match a newer home-manager; it only pins defaults that would
    # otherwise change underneath existing state.
    home.stateVersion = "26.05";

    # Installs the `home-manager` CLI. Not needed to apply this config - that
    # happens through nixos-rebuild - but it is what makes
    # `home-manager generations` and `home-manager news` work.
    programs.home-manager.enable = true;
  };
}
