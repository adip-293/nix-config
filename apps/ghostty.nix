{
  # Terminal. Bound to Super+G and Mod+T in ~/.config/niri/config.kdl on the
  # Linux machines, and used by Super+E to host yazi.
  home =
    { pkgs, ... }:
    {
      programs.ghostty = {
        enable = true;

        # nixpkgs has no darwin build - on macOS ghostty ships as a signed
        # .app from ghostty.org, installed outside Nix. A null package still
        # writes ~/.config/ghostty/config, so keybinds and theme stay shared;
        # it only skips installing the binary and validating the config
        # against it.
        package = if pkgs.stdenv.hostPlatform.isDarwin then null else pkgs.ghostty;

        # Anything set here lands on every machine that lists this app.
        settings = {
          # The Nerd Font patched build of ghostty's own default face, so the
          # icons neovim's UI draws have glyphs to render. Comes from the
          # `fonts` app; without that app listed, this name does not resolve
          # and ghostty silently falls back to the unpatched JetBrains Mono.
          font-family = "JetBrainsMono Nerd Font";
        };
      };
    };
}
