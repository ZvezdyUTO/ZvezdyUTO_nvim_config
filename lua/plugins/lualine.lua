return {
    "nvim-lualine/lualine.nvim",
    dependencies = {"nvim-tree/nvim-web-devicons"},
    config = function()
        require("lualine").setup({
            options = {
                theme = "onedark", -- 指定主题
                component_separators = {left = "", right = ""}, -- 更美观的分隔符
                section_separators = {left = "", right = ""}
                -- refresh = { -- 动态刷新策略
                -- 	statusline = 200, -- 每200ms刷新（适合实时信息）
                -- 	tabline = 1000,
                -- 	winbar = 200,
                -- },
            },
            sections = {
                lualine_a = {
                    {
                        "mode",
                        icon = ""
                        -- color = { bg = "#FF9E64", fg = "#1A1A1A" }
                    } -- 带图标的模式显示
                },
                lualine_b = {
                    "branch", {
                        "diff",
                        symbols = {
                            added = " ",
                            modified = " ",
                            removed = " "
                        } -- 更直观的diff图标
                        -- diff_color = {
                        -- 	added = { fg = "#98C379" },
                        -- 	modified = { fg = "#E5C07B" },
                        -- 	removed = { fg = "#E06C75" },
                        -- },
                    }, {
                        "diagnostics",
                        sources = {"nvim_diagnostic"},
                        symbols = {
                            error = " ",
                            warn = " ",
                            info = " ",
                            hint = " "
                        },
                        colored = true,
                        always_visible = false
                    }
                },
                lualine_c = {
                    {
                        "filename",
                        path = 1, -- 显示相对路径
                        symbols = {modified = " ●", readonly = " "}
                    }, {
                        "navic", -- 显示代码结构（需安装 nvim-navic）
                        color_correction = "static",
                        navic_opts = {highlight = true, depth_limit = 3}
                    }
                },
                lualine_x = {
                    {
                        require("lazy.status").updates, -- 显示插件更新数量（需 lazy.nvim）
                        cond = require("lazy.status").has_updates
                        -- color = { fg = "#FF9E64" },
                    }, {
                        "encoding",
                        fmt = string.upper, -- 显示为 UTF-8
                        cond = function()
                            return vim.bo.fileencoding ~= ""
                        end
                    },
                    {
                        "fileformat",
                        symbols = {unix = "", dos = "", mac = ""}
                    }, {"filetype", icon_only = true, colored = true}
                },
                lualine_y = {
                    {
                        "progress",
                        padding = {left = 1, right = 0}
                        -- color = { fg = "#61AFEF" },
                    }, {
                        "location"
                        -- color = { fg = "#C678DD" },
                    }
                }
            },
            extensions = {"nvim-tree", "toggleterm", "fugitive"} -- 扩展集成
        })
    end
}
