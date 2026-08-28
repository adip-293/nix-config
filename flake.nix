{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/062346a6d85bc4b49dfaa61c986e9c5be21217d1";

    # Per-user config - dotfiles, shell, app settings - for every machine, so
    # one home/ tree can be shared by a NixOS host and a nix-darwin one.
    # The branch tracks nixpkgs' release (26.05); mismatching the two means
    # home-manager modules referencing packages or options nixpkgs does not have.
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Neovim. nixCats' job is only to build an nvim with the right plugins on
    # its runtimepath - the editor config itself is ordinary Lua in
    # ./apps/neovim/. Deliberately no inputs.nixpkgs.follows: nixCats declares
    # no inputs at all, so there is nothing to redirect. It builds everything
    # from the nixpkgs above.
    nixCats.url = "github:BirdeeHub/nixCats-nvim";

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Pinned to the `cachix` branch, which always points at the newest commit
    # CI has already built. Deliberately no inputs.nixpkgs.follows here:
    # overriding its inputs changes the derivation hash and misses the binary
    # cache, which would mean compiling a C++/Qt app from source.
    noctalia.url = "github:noctalia-dev/noctalia/cachix";
  };

  outputs =
    inputs@{ self, nixpkgs, ... }:
    {
      nixosConfigurations = {
        thinkpad = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [ ./hosts/thinkpad ];
        };

        # desktop = nixpkgs.lib.nixosSystem {
        #   specialArgs = { inherit inputs; };
        #   modules = [ ./hosts/desktop ];
        # };
      };

      # macbook goes here as darwinConfigurations once nix-darwin is added. It
      # gets its own hosts/macbook/default.nix listing whichever apps make
      # sense there - "ghostty" "git" "yazi" "zsh" and not "citrix" "loupe"
      # "noctalia" "zen" - out of the same ./apps store. The only new plumbing
      # is a darwin copy of ./system/home-manager.nix using
      # inputs.home-manager.darwinModules.home-manager.
    };
}
