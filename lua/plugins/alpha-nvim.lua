return {
    "goolord/alpha-nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons", "nvim-lua/plenary.nvim" -- 新增必要依赖
    },
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")
        local path = require("plenary.path") -- 引入路径处理库

        -- 自定义 ASCII 艺术字
        dashboard.section.header.val = {
            [[███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
            [[████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
            [[██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
            [[██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
            [[██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
            [[╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]]
        }

        -- 获取最近项目列表 (修复版本)
        local function get_recent_projects()
            local projects = {}
            local seen = {}

            for _, file in ipairs(vim.v.oldfiles) do
                -- 过滤无效路径
                if vim.fn.filereadable(file) == 1 then
                    local project_path = path:new(file):parent().filename
                    -- 排除临时文件和非项目路径
                    if not project_path:match("tmp") and not seen[project_path] then
                        table.insert(projects, {
                            display = " " ..
                                path:new(project_path)
                                    :make_relative(vim.loop.cwd()),
                            path = project_path
                        })
                        seen[project_path] = true
                        if #projects >= 5 then break end
                    end
                end
            end
            return projects
        end

        -- 最近项目展示模块
        local recent_projects = {
            type = "group",
            val = {
                -- { type = "text", val = "Recent Projects", opts = { hl = "AlphaSectionTitle" } },
                {type = "padding", val = 1}, {
                    type = "group",
                    val = function()
                        local buttons = {}
                        for _, proj in ipairs(get_recent_projects()) do
                            table.insert(buttons,
                                         dashboard.button("p" .. _,
                                                          proj.display,
                                                          "<CMD>cd " ..
                                                              proj.path ..
                                                              " | NvimTreeFindFile<CR>"))
                        end
                        return buttons
                    end
                }
            }
        }

        -- 布局配置 (添加项目列表模块)
        dashboard.config.layout = {
            { -- Header
                type = "group",
                val = {
                    {
                        type = "padding",
                        val = function()
                            return math.floor(vim.o.lines * 0.15)
                        end
                    }, dashboard.section.header, {type = "padding", val = 2}
                }
            }, recent_projects, -- 插入项目列表
            {type = "padding", val = 2}, { -- Main Buttons
                type = "group",
                val = {dashboard.section.buttons, {type = "padding", val = 1}}
            }, { -- Footer
                type = "group",
                val = {
                    {
                        type = "padding",
                        val = function()
                            return math.floor(vim.o.lines * 0.1)
                        end
                    }, dashboard.section.footer
                }
            }
        }

        -- 按钮配置
        dashboard.section.buttons.val = {
            dashboard.button("t", "🌳 File Explorer",
                             "<CMD>NvimTreeToggle<CR>"),
            dashboard.button("f", "🔍 Find Files",
                             "<CMD>Telescope find_files<CR>"),
            dashboard.button("c", "⚙️  Edit Config",
                             "<CMD>edit $MYVIMRC<CR>")
        }

        -- 动态底部信息
        dashboard.section.footer.val = function()
            local stats = require("lazy").stats()
            local mem_usage = math.floor(collectgarbage("count") / 1024)
            return {
                "🚀 Neovim v" .. vim.version().major .. "." ..
                    vim.version().minor .. "." .. vim.version().patch,
                "📦 Plugins: " .. stats.loaded .. "/" .. stats.count,
                "💾 Memory: " .. mem_usage .. "MB",
                "🕒 " .. os.date("%Y-%m-%d %H:%M:%S")
            }
        end

        alpha.setup(dashboard.config)
    end
}
