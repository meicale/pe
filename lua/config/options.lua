-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

--- lua : https://tabby.tabbyml.com/docs/extensions/vim
vim.g.tabby_keybinding_accept = "9"
-- vim.g.tabby_keybinding_accept = '<Tab>'
vim.g.tabby_keybinding_trigger_or_dismiss = "<C-\\>"
-- https://neovide.dev/configuration.html#display
vim.g.neovide_transparency = 0.6
-- https://github.com/benlubas/molten-nvim/blob/main/docs/Virtual-Environments.md
vim.g.python3_host_prog = vim.fn.expand("~/micromamba/envs/neovim/bin/python3")

vim.opt.swapfile = false
