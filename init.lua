require("config.options") -- 加载基础设置
require("config.keymaps") -- 加载键位映射
require("config.autocmds") -- 加载自动命令

-- 初始化 lazy.nvim

-- 设置 Lazy.nvim 的安装路径
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- 检查 Lazy.nvim 是否存在并克隆
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
-- 确保路径分隔符统一为正斜杠
vim.opt.rtp:prepend(lazypath:gsub("\\", "/"))

-- 加载插件配置
require("lazy").setup({
	spec = {
		{ import = "plugins" }, -- 插件目录
		{ import = "plugins.alpha-nvim" }, -- Alpha启动页（独立文件）
	},
	defaults = { lazy = false }, -- 非懒加载启动插件
	performance = {
		rtp = {
			disabled_plugins = { -- 禁用内置插件
				"gzip",
				"tarPlugin",
				"tohtml",
				"zipPlugin",
			},
		},
	},
})
