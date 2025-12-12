return {
    "Mofiqul/dracula.nvim",
    lazy = false, -- 重要：主题插件需要立即加载
    priority = 1000, -- 最高优先级确保最先加载
    config = function()
        vim.cmd.colorscheme("dracula")
        -- 透明背景设置
        vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
        vim.cmd("hi NonText guibg=NONE ctermbg=NONE")
        vim.cmd("hi SignColumn guibg=NONE ctermbg=NONE")
    end
}
