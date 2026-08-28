-- snacks.nvim: one plugin, many small UI pieces, each independently switchable.
-- This is the entire plugin layer of the config.
--
-- Icons here are Nerd Font glyphs. The `fonts` app installs JetBrainsMono Nerd
-- Font and ghostty is set to use it, so they render; drop that app and this
-- turns into boxes.

require('snacks').setup({
  -- [[ Passive: these change how the editor looks and behaves, no keymaps ]]

  -- Turn off syntax, folding and other heavy features on very large files, so
  -- opening a 20MB log does not hang the editor.
  bigfile = { enabled = true },

  -- Render a file's first screen before loading plugins/autocommands, so
  -- `nvim file` shows text immediately.
  quickfile = { enabled = true },

  -- The start screen shown when neovim opens with no file.
  dashboard = {
    enabled = true,

    -- The sections have to be spelled out because snacks' default set ends
    -- with `{ section = "startup" }`, which reports startup time by calling
    -- require("lazy.stats") - a lazy.nvim module. Nix puts plugins on the
    -- runtimepath directly, so lazy.nvim does not exist here and that section
    -- throws on every launch. Everything below is the default minus that one.
    sections = {
      { section = 'header' },
      { section = 'keys', gap = 1, padding = 1 },
      { section = 'recent_files', icon = ' ', title = 'Recent files', padding = 1 },
    },
  },

  -- Vertical guides at each indent level, plus a highlight of the scope the
  -- cursor is in.
  indent = { enabled = true },
  scope = { enabled = true },

  -- Replaces the number/sign column with one that folds git signs, marks and
  -- diagnostics together instead of stacking columns.
  statuscolumn = { enabled = true },

  -- Animate <C-d>/<C-u> and friends rather than teleporting, which makes it
  -- much easier to keep track of where you are in a file.
  scroll = { enabled = true },

  -- Underline the other occurrences of the symbol under the cursor.
  words = { enabled = true },

  -- Route vim.notify through a proper notification popup, and give vim.input
  -- (used by rename prompts and similar) a floating window instead of the
  -- one-line command area.
  notifier = { enabled = true },
  input = { enabled = true },

  -- [[ Active: these are reached through the keymaps below ]]
  picker = { enabled = true },
  explorer = { enabled = true },
})

-- Snacks is a global, set by the setup call above.

-- Finding things. <leader> is space.
vim.keymap.set('n', '<leader>ff', function() Snacks.picker.files() end, { desc = 'Find files' })
vim.keymap.set('n', '<leader>fg', function() Snacks.picker.grep() end, { desc = 'Grep in files' })
vim.keymap.set('n', '<leader>fb', function() Snacks.picker.buffers() end, { desc = 'Find open buffers' })
vim.keymap.set('n', '<leader>fh', function() Snacks.picker.help() end, { desc = 'Find help tags' })
vim.keymap.set('n', '<leader>fr', function() Snacks.picker.recent() end, { desc = 'Find recent files' })

-- Everything else.
vim.keymap.set('n', '<leader>e', function() Snacks.explorer() end, { desc = 'Toggle file explorer' })
vim.keymap.set('n', '<leader>n', function() Snacks.notifier.show_history() end, { desc = 'Notification history' })
