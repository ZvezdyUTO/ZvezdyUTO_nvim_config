return {
    "lewis6991/gitsigns.nvim",
    lazy = true,
    event = {"BufRead", "BufNewFile"}, -- 当打开或创建文件时加载
    config = function() require("gitsigns").setup() end
}
