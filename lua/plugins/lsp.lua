return {
	"neovim/nvim-lspconfig",
	lazy = false,
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		require("lspconfig").clangd.setup({
			cmd = { "clangd", "--header-insertion=never" },
			capabilities = capabilities,
		})
		--[[ require("lspconfig").sqls.setup({ ]]
		--[[ 	cmd = { "/home/zvezdy/go/bin/sqls" }, ]]
		--[[ }) ]]

		-- 诊断配置（右侧显示错误信息 + 当前行高亮）
		vim.diagnostic.config({
			virtual_text = {
				format = function(diagnostic)
					return string.format("%s (%s)", diagnostic.message, diagnostic.source)
				end,
				spacing = 2,
				align = "right",
			},
			signs = false,
			update_in_insert = false,
			underline = true,
			severity_sort = true,
			float = { -- 悬浮窗显示完整信息
				border = "rounded",
				source = "always",
			},
		})

		vim.api.nvim_create_autocmd("cursorhold", {
			callback = function()
				vim.diagnostic.open_float({ scope = "line" })
			end,
		})
	end,
}
