local group = vim.api.nvim_create_augroup("MyAutoCmds", { clear = true })

-- 设置启动时自动切换到 ~/code 目录
vim.api.nvim_create_autocmd("VimEnter", {
	pattern = "*",
	callback = function()
		-- 确保目录存在
		local code_dir = vim.fn.expand("~/code")
		if vim.fn.isdirectory(code_dir) == 0 then
			vim.fn.mkdir(code_dir, "p")
			vim.notify("Created directory: " .. code_dir)
		end

		-- 只有直接运行 nvim（无文件参数）时跳转
		if vim.fn.argc() == 0 then
			vim.cmd("cd " .. code_dir)
			-- vim.cmd('echom "Welcome, Utonut-Zvezdy"')
			-- vim.notify("Welcome, Utonut-Zvezdy")
		end
	end,
})

-- 设置内置终端默认目录
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	callback = function()
		-- 获取当前窗口的目录
		local cwd = vim.fn.getcwd()
		-- 如果不在 ~/code 则切换
		if not string.find(cwd, "/code$") then
			vim.cmd("lcd ~/code")
		end
	end,
})

-- 增强文件类型检测
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*",
	callback = function()
		-- 识别特殊文件类型
		local special_files = {
			[".eslintrc"] = "json",
			[".prettierrc"] = "json",
			["tsconfig.json"] = "jsonc",
			[".babelrc"] = "json",
		}
		local filename = vim.fn.expand("%:t")
		if special_files[filename] then
			vim.bo.filetype = special_files[filename]
		end
	end,
})

--[[ -- 保护 sidebar.nvim，避免与 toggleterm 关闭窗口时产生冲突 ]]
--[[ vim.api.nvim_create_autocmd("DirChanged", { ]]
--[[ 	group = group, -- 放进你已有的 MyAutoCmds group ]]
--[[ 	callback = function() ]]
--[[ 		vim.schedule(function() ]]
--[[ 			-- 安全调用 sidebar.nvim.open（刷新 / 自动打开） ]]
--[[ 			local ok, sidebar = pcall(require, "sidebar-nvim") ]]
--[[ 			if ok then ]]
--[[ 				pcall(sidebar.open) ]]
--[[ 			end ]]
--[[ 		end) ]]
--[[ 	end, ]]
--[[ }) ]]
