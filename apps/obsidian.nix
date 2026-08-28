{
  # Notes. Unfree (proprietary Electron app); allowUnfree is set once in
  # ../system/core.nix and applies here too, because home-manager runs with
  # useGlobalPkgs. Vaults are plain directories of Markdown files, so nothing
  # here needs to know where they live.
  home =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ obsidian ];
    };
}
