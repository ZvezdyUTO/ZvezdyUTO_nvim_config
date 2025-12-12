-- ~/.config/nvim/lua/plugins/screenkey.lua
return {
    "NStefan002/screenkey.nvim",
    lazy = false,
    version = "*",
    config = function()
        local ok, sk = pcall(require, "screenkey")
        if not ok or type(sk) ~= "table" then
            vim.schedule(function()
                vim.notify("screenkey.nvim load failed", vim.log.levels.WARN)
            end)
            return
        end

        vim.api.nvim_create_autocmd("VimEnter", {
            once = true,
            callback = function()
                local cols = vim.o.columns
                local lines = vim.o.lines
                local cmdh = vim.o.cmdheight or 1

                local w = 27
                local row = lines - cmdh - 1
                local col = cols - 1

                -- 过滤函数：去掉形如 <e5> <95> <8a> 的纯 hex 字节项，
                -- 但保留像 <TAB> <CR> <C-x> 这种合法的“命名按键”
                local function filter_hex_bytes(keys)
                    local out = {}
                    for _, k in ipairs(keys) do
                        local keystr = tostring(k.key or "")
                        -- 如果是形如 "<xx>" 且 xx 是两个十六进制字符 -> 跳过（这是 UTF-8 的单字节显示）
                        if keystr:match("^<%x%x>$") then
                            -- skip
                        else
                            table.insert(out, k)
                        end
                    end
                    return out
                end

                local ok2, err = pcall(function()
                    sk.setup({
                        win_opts = {
                            relative = "editor",
                            anchor = "SE",
                            row = row,
                            col = col,
                            width = w,
                            height = 1,
                            border = "rounded",
                            style = "minimal",
                            focusable = false,
                            noautocmd = true
                            -- winblend = 100
                        },
                        compress_after = 7,
                        clear_after = 3,
                        show_leader = false,
                        -- 关键：把 filter 注册进去，返回过滤后的 keys 列表
                        filter = function(keys)
                            return filter_hex_bytes(keys)
                        end
                    })
                    -- 把下面这两行放在 setup 之后，仅在你想让所有浮窗背景为 NONE 时使用：
                    -- vim.api.nvim_set_hl(0, "NormalFloat", {bg = "NONE"})
                    -- vim.api.nvim_set_hl(0, "FloatBorder",
                    --                    {bg = "NONE", fg = "#6aa0c6"})
                end)
                if not ok2 then
                    vim.schedule(function()
                        vim.notify("screenkey.setup failed: " .. tostring(err),
                                   vim.log.levels.WARN)
                    end)
                    return
                end

                -- 自动打开一次
                vim.defer_fn(function()
                    if type(sk.toggle) == "function" then
                        sk.toggle()
                    end
                end, 150)
            end
        })

        vim.keymap.set("n", "<leader>ks", function()
            local ok3, sk2 = pcall(require, "screenkey")
            if ok3 and type(sk2.toggle) == "function" then
                sk2.toggle()
            end
        end, {desc = "Toggle screenkey (small, bottom-right)"})
    end
}
