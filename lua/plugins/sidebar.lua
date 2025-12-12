return {
	"sidebar-nvim/sidebar.nvim",
	config = function()
		local sidebar = require("sidebar-nvim")

		sidebar.setup({
			open = true, -- 启动时自动打开
			side = "left",
			initial_width = 27,
			hide_statusline = false,
			update_interval = 1000, -- 1s 刷新一次

			bindings = {
				["q"] = function()
					sidebar.close()
				end,
			},

			sections = {
				"datetime",
				"files",
				"diagnostics",
				"git",
				"buffers",
				"todos",
				-- "symbols",
			},

			section_separator = { "", "━", "" },

			files = {
				icon = "",
				show_hidden = false,
			},

			symbols = {
				icon = "",
				selector = function(entry)
					return entry.icon .. " " .. entry.name
				end,
			},

			datetime = {
				icon = "",
				format = "%H:%M:%S  %Y/%m/%d",
				clocks = { { name = "local" } },
			},
		})

		-- ⚠ 改成“延迟刷新”，不再同步 close/open
		vim.api.nvim_create_autocmd("DirChanged", {
			callback = function()
				vim.schedule(function()
					local ok, sb = pcall(require, "sidebar-nvim")
					if ok then
						-- 如果你只想刷新内容，推荐用 update()
						if sb.update then
							pcall(sb.update)
						else
							-- 老版本没有 update，就保守一点，只在已打开时再 open 一次
							pcall(sb.open)
						end
					end
				end)
			end,
		})
	end,
}
