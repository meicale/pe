-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>g3", "<cmd>Gvdiffsplit!<cr>", { desc = "conflicts 3-way" })
vim.keymap.set("n", "<leader>gl", "<cmd>diffget //2<cr>", { desc = "Get left diff" })
vim.keymap.set("n", "<leader>gr", "<cmd>diffget //3<cr>", { desc = "Get right diff" })

vim.keymap.set("n", "ha", "@a", { desc = "Macro a" })
vim.keymap.set("n", "hs", "@s", { desc = "Macro s" })
vim.keymap.set("n", "hd", "@d", { desc = "Macro d" })
vim.keymap.set("n", "hf", "@f", { desc = "Macro f" })
vim.keymap.set("n", "hg", "@g", { desc = "Macro g" })
vim.keymap.set("n", "hj", "@j", { desc = "Macro j" })
vim.keymap.set("n", "hk", "@k", { desc = "Macro k" })
vim.keymap.set("n", "hl", "@l", { desc = "Macro l" })
