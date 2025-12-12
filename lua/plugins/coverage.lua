return {
    "andythigpen/nvim-coverage",
    dependencies = "neovim/nvim-lspconfig",
    config = function()
        require("coverage").setup({
            auto_reload = true, -- 自动刷新覆盖率
            lang = { -- 按需启用语言支持
                python = true,
                javascript = true,
                go = true
            }
        })
    end
}
