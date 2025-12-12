--[[ return { ]]
--[[     'echasnovski/mini.nvim', ]]
--[[     version = false, ]]
--[[     config = function() ]]
--[[         require('mini.files').setup({ ]]
--[[             mappings = { ]]
--[[                 close = 'q', ]]
--[[                 go_in = 'l', ]]
--[[                 go_out = 'h', ]]
--[[                 synchronize = '<CR>' ]]
--[[             }, ]]
--[[             windows = {preview = true, width_focus = 50} ]]
--[[         }) ]]
--[[]]
--[[         vim.keymap.set('n', '<leader>e', function() ]]
--[[             if not MiniFiles.close() then MiniFiles.open() end ]]
--[[         end, {desc = 'Toggle file explorer'}) ]]
--[[]]
--[[         require('mini.icons').setup() ]]
--[[]]
--[[         require('mini.indentscope').setup() ]]
--[[]]
--[[     end ]]
--[[ } ]]
return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		-- =========================
		--  Mini Files 主配置
		-- =========================
		require("mini.files").setup({
			mappings = {
				close = "q",
				go_in = "l",
				go_out = "h",
				synchronize = "<CR>",
			},
			windows = {
				preview = true,
				width_focus = 50,
			},
		})

		-- =========================
		--  <leader>e 打开/关闭 mini.files
		-- =========================
		vim.keymap.set("n", "<leader>e", function()
			if not MiniFiles.close() then
				MiniFiles.open()
			end
		end, { desc = "Toggle file explorer" })

		-- =========================
		--  在 mini.files 内设置 cwd
		--  关键：必须放在 setup 外！
		-- =========================
		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesBufferCreate",
			callback = function(args)
				local buf_id = args.data.buf_id

				-- 设置当前目录为 cwd 的函数
				local function set_cwd()
					local mf = require("mini.files")
					local entry = mf.get_fs_entry()
					if not entry then
						return
					end

					local path = entry.path
					local dir = vim.fs.dirname(path)

					if dir then
						vim.fn.chdir(dir)
						print("CWD → " .. dir)
					end
				end

				-- 给 mini.files buffer 分配按键
				vim.keymap.set("n", "gc", set_cwd, {
					buffer = buf_id,
					desc = "Set cwd to directory under cursor",
				})
			end,
		})

		-- =========================
		--  其它 mini 组件 (你原来就有)
		-- =========================
		require("mini.icons").setup()
		require("mini.indentscope").setup()
	end,
}
