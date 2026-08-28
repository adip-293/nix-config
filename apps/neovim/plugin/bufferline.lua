-- Open buffers as tabs along the top.
--
-- Worth knowing the distinction, because it trips everyone up coming from
-- other editors: these are neovim *buffers*, not neovim *tabs*. A neovim tab
-- is a whole window layout, closer to a workspace. What every other editor
-- calls a tab is a buffer, which is what this shows.

-- Always draw the tab row, even with a single file open, so the layout does
-- not shift the moment you open a second one.
vim.o.showtabline = 2

require('bufferline').setup({
  options = {
    mode = 'buffers',

    -- Underline the buffer's entry when it has an LSP error or warning. Does
    -- nothing until a language server is configured, which is not yet.
    diagnostics = 'nvim_lsp',

    separator_style = 'slant',

    -- A close button per buffer is useful; a single global one in the corner
    -- is just an easy misclick.
    show_buffer_close_icons = true,
    show_close_icon = false,
  },
})

-- Shift-h and shift-l move left and right along the row, matching the h/l
-- you already use for horizontal motion.
vim.keymap.set('n', '<S-h>', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<S-l>', '<cmd>BufferLineCycleNext<CR>', { desc = 'Next buffer' })

-- Snacks' version rather than :bdelete, because plain :bdelete closes the
-- window along with the buffer and collapses your split layout.
vim.keymap.set('n', '<leader>bd', function() Snacks.bufdelete() end, { desc = 'Delete buffer' })
vim.keymap.set('n', '<leader>bo', function() Snacks.bufdelete.other() end, { desc = 'Delete other buffers' })

-- Pinned buffers stay at the left of the row and survive "delete others".
vim.keymap.set('n', '<leader>bp', '<cmd>BufferLineTogglePin<CR>', { desc = 'Pin/unpin buffer' })
