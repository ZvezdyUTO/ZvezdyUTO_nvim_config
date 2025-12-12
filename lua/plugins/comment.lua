return {
    "numToStr/Comment.nvim",
    lazy = false,
    dependencies = {"JoosepAlviste/nvim-ts-context-commentstring"},
    config = function()
        require("Comment").setup({
            pre_hook = function(ctx)
                -- 获取文件类型
                local filetype = vim.bo.filetype

                -- 针对C++文件强制使用//注释
                if filetype == "cpp" then
                    local commentstring = vim.bo.commentstring
                    -- 确保使用//注释
                    if not commentstring:match("//") then
                        vim.bo.commentstring = "// %s"
                    end
                    return nil -- 返回nil让插件使用修改后的commentstring
                end

                -- 其他文件类型保持智能检测
                local U = require("Comment.utils")
                local location = nil
                if ctx.ctype == U.ctype.block then
                    location =
                        require("ts_context_commentstring.utils").get_cursor_location()
                end
                return
                    require("ts_context_commentstring.internal").calculate_commentstring(
                        {
                            key = ctx.ctype == U.ctype.line and "__default" or
                                "__multiline",
                            location = location
                        })
            end,
            -- 显式设置C++的注释风格
            opleader = {line = "gc", block = "gb"},
            toggler = {line = "gcc", block = "gbc"},
            extra = {above = "gcO", below = "gco", eol = "gcA"}
        })
    end,
    keys = {
        {"gc", mode = {"n", "v"}, desc = "Toggle comment (line/block)"},
        {"gcc", mode = "n", desc = "Toggle current line"},
        {"gb", mode = {"n", "v"}, desc = "Toggle block comment"},
        {"gbc", mode = "n", desc = "Toggle current block"}
    }
}
