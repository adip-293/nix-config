require('lualine').setup({
  options = {
    -- Derives colors from the active colorscheme, so changing retrobox in
    -- colorscheme.lua re-themes the statusline with it.
    theme = 'auto',

    -- One statusline across the bottom of the whole editor rather than one per
    -- split. With several splits open the per-window version wastes a lot of
    -- rows repeating the same information.
    globalstatus = true,

    -- Powerline separators. These are Nerd Font glyphs, from the `fonts` app.
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
  },

  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },

    -- path = 1 shows the path relative to the working directory, rather than
    -- just the basename - the difference between five open `init.lua` tabs
    -- being distinguishable or not.
    lualine_c = { { 'filename', path = 1 } },

    lualine_x = { 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
})
