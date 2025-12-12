return {
    "HiPhish/rainbow-delimiters.nvim",
    dependencies = {"nvim-treesitter/nvim-treesitter"}, -- 必须依赖
    config = function()
        -- 基础配置（可选）
        require("rainbow-delimiters.setup").setup()
    end
}
