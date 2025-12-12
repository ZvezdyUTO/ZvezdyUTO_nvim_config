local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

vim.opt.mouse = ""

vim.g.clipboard = {
  name = 'OSC52',
  copy = {
    ["+"] = require('vim.ui.clipboard.osc52').copy("+"),
    ["*"] = require('vim.ui.clipboard.osc52').copy("*"),
  },
  paste = {
    ["+"] = require('vim.ui.clipboard.osc52').paste("+"),
    ["*"] = require('vim.ui.clipboard.osc52').paste("*"),
  },
}

vim.keymap.set("n", "<Leader>q", ":CompetiTest run<CR>", { desc = "运行所有测试用例" })
vim.keymap.set("n", "<Leader>add", ":CompetiTest add_testcase<CR>", { desc = "添加测试用例" })
vim.keymap.set("n", "<Leader>chg", ":CompetiTest edit_testcase<CR>", { desc = "编辑测试用例" })
vim.keymap.set("n", "<Leader>del", ":CompetiTest delete_testcase<CR>", { desc = "删除测试用例" })
vim.keymap.set("n", "<Leader>lst", ":CompetiTest show_ui<CR>", { desc = "查看上一次测试结果" })
