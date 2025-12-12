return {
	"stevearc/overseer.nvim",
	config = function()
		require("overseer").setup()

		-- 快捷键绑定
		vim.keymap.set("n", "<leader>r", "<cmd>OverseerRun<CR>", { desc = "Run Task" })
		vim.keymap.set("n", "<leader>o", "<cmd>OverseerToggle<CR>", { desc = "Toggle Overseer" })
		vim.keymap.set("n", "<leader>R", "<cmd>OverseerRunCmd<CR>", { desc = "Run Command" })
	end,
}
