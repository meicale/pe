-- if vim.g.neovide then
-- Put anything you want to happen only in Neovide here
-- vim.g.neovide_fullscreen = true
-- end
vim.g.neovide_cursor_vfx_mode = "pixiedust"
vim.g.neovide_opacity = 0.6
vim.g.neovide_normal_opacity = 0.6
vim.g.neovide_title_background_color = "black"
vim.g.neovide_title_text_color = "green"
vim.o.guicursor =
  "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor,sm:block-blinkwait175-blinkoff150-blinkon175"
--  设置光标颜色
--  highlight Cursor guifg=#FFFFFF guibg=#FF0000  " GUI 前景白色，背景红色
-- highlight Cursor ctermfg=15 ctermbg=160       " 终端前景白色，背景红色
-- 设置光标高亮组
vim.api.nvim_set_hl(0, "Cursor", {
  fg = "#FFFFFF", -- 前景色（白色）
  bg = "#FF0000", -- 背景色（红色）
  ctermfg = 15, -- 终端前景色（白色）
  ctermbg = 160, -- 终端背景色（红色）
})

-- 插入模式光标
vim.api.nvim_set_hl(0, "CursorI", {
  bg = "#00FF00", -- 绿色光标
  ctermbg = 46,
})

-- 可视模式光标
vim.api.nvim_set_hl(0, "CursorV", {
  bg = "#0000FF", -- 蓝色光标
  ctermbg = 21,
})

-- 应用设置（在 colorscheme 加载后）
vim.cmd([[
  augroup CursorColors
    autocmd!
    autocmd ColorScheme * lua require('config.cursor').setup_colors()
  augroup END
]])

return {
  setup_colors = function()
    vim.api.nvim_set_hl(0, "Cursor", { bg = "#FF0000" })
    -- 添加其他模式设置...
  end,
}
