{
  # Fonts available to this user's applications.
  #
  # This exists because neovim's UI (snacks) and most terminal tooling draw
  # icons using Nerd Font glyphs, which live in a private Unicode range that
  # ordinary fonts do not cover. Without a Nerd Font installed, every icon
  # renders as an empty box.
  #
  # JetBrainsMono specifically because it is ghostty's default face, so
  # ../apps/ghostty.nix is only swapping in the patched version of a font it
  # was already using.
  home =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];

      # Generates the fontconfig files that let applications actually find the
      # fonts installed above. Without this the package is on disk but nothing
      # can look it up by name.
      fonts.fontconfig.enable = true;
    };
}
