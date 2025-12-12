return {
    "declancm/cinnamon.nvim",
    version = "*",
    opts = {},
    config = function(_, opts)
        require("cinnamon").setup({
            keymaps = {basic = true, extra = true},
            options = {mode = "scroll", delay = 7, max_delta = {time = 100}}
        })
    end
}
