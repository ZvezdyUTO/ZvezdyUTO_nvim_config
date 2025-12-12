-- 基础设置
vim.opt.tabstop = 4 -- 设置 Tab 为 4 个空格宽度
vim.opt.shiftwidth = 4 -- 设置自动缩进为 4 个空格
vim.opt.expandtab = true -- 用空格代替 Tab
vim.opt.undofile = false -- 禁用临时文件
vim.opt.backup = false -- 禁用备份文件
vim.opt.swapfile = false -- 禁用交换文件
vim.wo.number = true -- 显示行号
vim.opt.wrap = false -- 取消自动换行

-- 剪切到系统剪贴板
vim.api.nvim_set_keymap("v", "<C-x>", '"+x', {noremap = true, silent = true})
vim.api.nvim_set_keymap("v", "<C-c>", '"+y', {noremap = true, silent = true})
