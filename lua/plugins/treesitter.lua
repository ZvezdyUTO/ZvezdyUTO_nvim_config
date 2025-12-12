return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {"c", "cpp", "lua", "python", "javascript"}, -- 按需添加语言
            highlight = {enable = true}, -- 启用语法高亮
            indent = {enable = true} -- 智能缩进
        })
    end
}
