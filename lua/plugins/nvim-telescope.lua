return {
    "nvim-telescope/telescope.nvim",
    dependencies = {"nvim-lua/plenary.nvim"},
    config = function()
        local builtin = require("telescope.builtin")
        -- 快捷键设置
        vim.keymap.set("n", "<leader>ff", builtin.find_files,
                       {desc = "Find Files"})
        -- vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
    end
}
