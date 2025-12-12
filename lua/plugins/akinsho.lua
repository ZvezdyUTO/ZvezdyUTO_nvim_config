return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup({
            direction = "float",
            float_opts = {
                border = "rounded",
                width = function()
                    return math.min(100, vim.o.columns - 20)
                end, -- 宽度减少20列留出右边空间
                height = function()
                    return math.min(30, vim.o.lines - 10)
                end,
                -- 修改此处实现右移 ▼
                row = function() return (vim.o.lines - 30) * 0.5 end, -- 保持垂直居中
                col = function() return vim.o.columns * 0.2 end, -- 水平位置从10%开始（右移效果）
                -- 替代方案：固定像素右移（二选一）
                -- col = function() return (vim.o.columns - 100) * 0.5 + 20 end, -- 中心点+20像素右移
                winblend = 10 -- 透明度(0-100)
            },
            open_mapping = [[<c-\>]]
        })
    end
}
