{
  # Neovim, built by nixCats.
  #
  # The split is the reason for picking nixCats: this file says *what Nix
  # provides* - which plugins and which external tools exist - and ./neovim/
  # says *how the editor behaves*, in plain Lua. ./neovim/ is a normal neovim
  # config directory; ./neovim/init.lua would work as-is on a machine with no
  # Nix at all.
  #
  # Adding a plugin is therefore two steps, on purpose:
  #   1. add it to startupPlugins below, so Nix puts it on the runtimepath
  #   2. configure it in ./neovim/plugin/<name>.lua, in its own Lua API
  home =
    { inputs, ... }:
    {
      imports = [ inputs.nixCats.homeModule ];

      nixCats = {
        enable = true;

        # Which of the packageDefinitions below to actually install.
        packageNames = [ "nvim" ];

        # The Lua config directory.
        luaPath = ./neovim;

        # What Nix makes available, grouped into named categories. A category
        # is just a label; the package below switches it on or off. Same idea
        # as the app list in hosts/<host>/default.nix, one level down - a host
        # could take `general` without a heavyweight language category, from
        # these same files.
        categoryDefinitions.replace =
          { pkgs, ... }:
          {
            startupPlugins = {
              general = with pkgs.vimPlugins; [
                # A collection of small UI pieces behind a single setup call -
                # picker, file explorer, dashboard, notifications, indent
                # guides. Most of the interface is this one plugin.
                snacks-nvim

                # Statusline along the bottom.
                lualine-nvim

                # Buffer tabs along the top.
                bufferline-nvim

                # The filetype icons both of the above draw. Neither hard
                # depends on it - they silently fall back to no icons - so it
                # has to be listed explicitly rather than arriving as a
                # dependency.
                nvim-web-devicons
              ];
            };

            # Ordinary programs that must be on PATH for plugins to work.
            # nixCats puts these on neovim's PATH specifically, so they do not
            # leak into the rest of the user environment.
            lspsAndRuntimeDeps = {
              general = with pkgs; [
                # snacks' picker shells out to these: ripgrep for grep-in-files,
                # fd for the file list. Without them the picker silently finds
                # nothing.
                ripgrep
                fd
              ];
            };
          };

        packageDefinitions.replace = {
          nvim =
            { ... }:
            {
              settings = {
                # Bake ./neovim into the store rather than reading
                # ~/.config/nvim, so the editor config is versioned and rolled
                # back with everything else. The cost is that editing Lua needs
                # a rebuild to take effect; nixCats' wrapRc = false plus
                # unwrappedCfgPath is the escape hatch if that gets tiring.
                wrapRc = true;

                # `vim` also opens this neovim. Must not collide with another
                # package's aliases.
                aliases = [ "vim" ];
              };

              categories = {
                general = true;
              };
            };
        };
      };
    };
}
