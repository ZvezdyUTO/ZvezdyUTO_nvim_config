return {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                -- 各语言配置（优先使用项目本地配置）
                c = {"clang-format"},
                cpp = {"clang-format"},
                python = {"isort", "black"},
                javascript = {{"prettierd", "prettier"}},
                typescript = {{"prettierd", "prettier"}},
                javascriptreact = {{"prettierd", "prettier"}},
                typescriptreact = {{"prettierd", "prettier"}},
                json = {{"prettierd", "prettier"}},
                html = {{"prettierd", "prettier"}},
                css = {{"prettierd", "prettier"}},
                scss = {{"prettierd", "prettier"}},
                markdown = {{"prettierd", "prettier"}},
                lua = {"stylua"},
                go = {"gofumpt"},
                rust = {"rustfmt"},
                sh = {"shfmt"}
                -- 添加其他文件类型...
            },
            formatters = {
                -- 各格式化器自定义配置
                ["clang-format"] = {
                    args = {"--style=file", "-assume-filename=$FILENAME"}
                },
                ["prettierd"] = {
                    cwd = require("conform.util").root_file({
                        ".prettierrc", ".prettierrc.json", ".prettierrc.yml",
                        ".prettierrc.yaml", ".prettierrc.json5",
                        ".prettierrc.js", ".prettierrc.cjs",
                        "prettier.config.js", "prettier.config.cjs"
                    })
                },
                ["stylua"] = {args = {"--search-parent-directories", "-"}},
                ["black"] = {
                    args = {"--quiet", "-"},
                    cwd = require("conform.util").root_file({"pyproject.toml"})
                },
                ["shfmt"] = {args = {"-i", "2", "-ci"}},
                ["rustfmt"] = {args = {"--edition", "2021"}}
            },
            format_on_save = {timeout_ms = 2000, lsp_fallback = true}
        })

        -- 统一格式化快捷键
        vim.keymap.set({"n", "v"}, "<leader>fm", function()
            require("conform").format({async = true})
        end, {desc = "Format code"})
    end
}
