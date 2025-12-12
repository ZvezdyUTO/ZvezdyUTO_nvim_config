local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

-- 系统剪贴板
map("v", "<C-x>", '"+x')
map("v", "<C-c>", '"+y')

-- 自定义命令
vim.api.nvim_create_user_command("CF", "r ~/template.cpp", {})
vim.api.nvim_create_user_command("MAKE", "r ~/problem_maker.cpp", {})

vim.keymap.set("n", "<Leader>q", ":CompetiTest run<CR>", { desc = "运行所有测试用例" })
vim.keymap.set("n", "<Leader>add", ":CompetiTest add_testcase<CR>", { desc = "添加测试用例" })
vim.keymap.set("n", "<Leader>chg", ":CompetiTest edit_testcase<CR>", { desc = "编辑测试用例" })
vim.keymap.set("n", "<Leader>del", ":CompetiTest delete_testcase<CR>", { desc = "删除测试用例" })
vim.keymap.set("n", "<Leader>lst", ":CompetiTest show_ui<CR>", { desc = "查看上一次测试结果" })
