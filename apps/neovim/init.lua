-- Neovim's entry point.
--
-- This is a normal init.lua. nixCats bakes this whole directory into the Nix
-- store and points neovim at it, but nothing here is Nix-specific - anything
-- you would write in ~/.config/nvim/init.lua works unchanged.
--
-- Plugins are not installed from here. Nix provides them (see ../neovim.nix);
-- this directory only configures them, one file per plugin in plugin/.

-- Must be set before any plugin loads, or plugin mappings attach to the wrong
-- key. This is why it is at the top of init.lua and not in plugin/.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Options ]] see :help vim.o

vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true

-- Always draw the sign column, so the text does not jump sideways the moment
-- gitsigns has something to show.
vim.o.signcolumn = 'yes'

-- Keep some context visible above and below the cursor.
vim.o.scrolloff = 8
vim.o.wrap = false

-- Indent: two spaces by default. vim-sleuth overrides this per file whenever
-- it can tell what the file itself actually uses, which is most of the time.
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.breakindent = true

-- Search: case-insensitive, unless you type a capital.
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = 'split' -- live preview while typing a :substitute

-- Undo history survives closing the file.
vim.o.undofile = true

-- Share the system clipboard, so yanking here pastes into the browser.
-- Scheduled rather than set directly: on Wayland this shells out to
-- wl-clipboard, and doing that during startup measurably delays the first
-- frame.
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- New splits open where you are looking.
vim.o.splitright = true
vim.o.splitbelow = true

vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.mouse = 'a'

-- Ask about unsaved changes instead of refusing to quit.
vim.o.confirm = true

-- Make the whitespace that usually causes problems visible.
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- [[ Keymaps ]]
--
-- These are the shortcuts that follow you between machines: add one here,
-- rebuild, push, and it exists on the desktop and the macbook after a pull.
-- <leader> is space, set above.

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })
vim.keymap.set('n', '<leader>w', '<cmd>write<CR>', { desc = 'Write file' })
vim.keymap.set('n', '<leader>q', '<cmd>quit<CR>', { desc = 'Quit window' })

-- Move between splits without the <C-w> prefix.
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Go to left window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Go to lower window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Go to upper window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Go to right window' })

-- On a wrapped line, j and k move by what you see rather than by the logical
-- line - unless a count was given, so 5j still jumps five real lines.
vim.keymap.set('n', 'j', function()
  return vim.v.count > 0 and 'j' or 'gj'
end, { expr = true, desc = 'Down (by screen line)' })
vim.keymap.set('n', 'k', function()
  return vim.v.count > 0 and 'k' or 'gk'
end, { expr = true, desc = 'Up (by screen line)' })

-- Keep the cursor centred when paging through a file.
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Half page down, centred' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Half page up, centred' })

-- Re-indent without losing the selection.
vim.keymap.set('v', '<', '<gv', { desc = 'Outdent selection' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent selection' })

-- [[ Autocommands ]]

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Briefly highlight the text that was just yanked',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    -- vim.highlight was renamed vim.hl in neovim 0.11; accept either so this
    -- file stays valid if nixpkgs moves in one direction or the other.
    (vim.hl or vim.highlight).on_yank()
  end,
})
