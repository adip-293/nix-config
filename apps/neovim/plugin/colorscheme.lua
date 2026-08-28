-- retrobox ships with neovim itself - no colorscheme plugin involved. It is
-- the warm dark gruvbox-style palette, which is the closest built-in to the
-- Miasma scheme noctalia and the ly greeter already use.
--
-- To match that palette exactly instead of approximately, add `miasma-nvim` to
-- startupPlugins in ../../neovim.nix and change the name below.
vim.o.termguicolors = true
vim.cmd.colorscheme('retrobox')
