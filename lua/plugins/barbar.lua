return {
    'romgrk/barbar.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons', -- 文件图标
        'lewis6991/gitsigns.nvim' -- Git 状态
    },
    event = 'VeryLazy', -- 延迟加载
    keys = { -- 提前定义快捷键，帮助 lazy.nvim 识别
        {'<A-,>', '<Cmd>BufferPrevious<CR>', desc = 'Previous buffer'},
        {'<A-.>', '<Cmd>BufferNext<CR>', desc = 'Next buffer'},
        {'<A-<>', '<Cmd>BufferMovePrevious<CR>', desc = 'Move buffer left'},
        {'<A->>', '<Cmd>BufferMoveNext<CR>', desc = 'Move buffer right'},
        {'<A-c>', '<Cmd>BufferClose<CR>', desc = 'Close buffer'},
        {'<leader>bb', '<Cmd>BufferPick<CR>', desc = 'Pick buffer'}
    },
    opts = { -- 配置选项
        -- ===== 基础设置 =====
        animation = true,
        auto_hide = false,
        clickable = true,
        focus_on_close = 'left',
        highlight_visible = true,
        highlight_inactive_file_icons = false,

        -- ===== 侧边栏偏移 =====
        sidebar_filetypes = {
            NvimTree = true,
            Outline = {text = ' ', align = 'right'},
            undotree = {text = 'Undo Tree', align = 'left'}
        },

        -- ===== 图标设置 =====
        icons = {
            buffer_index = true, -- 显示缓冲区索引 (1, 2, 3...)
            buffer_number = false,
            button = '󰖭', -- 关闭按钮
            separator = {left = '▎', right = ''},

            -- 文件类型图标
            filetype = {enabled = true, custom_colors = false},

            -- Git 状态
            gitsigns = {
                added = {enabled = true, icon = '│'},
                changed = {enabled = true, icon = '│'},
                deleted = {enabled = true, icon = '󰍵'}
            },

            -- 诊断信息
            diagnostics = {
                [vim.diagnostic.severity.ERROR] = {enabled = true, icon = ''},
                [vim.diagnostic.severity.WARN] = {enabled = true, icon = ''},
                [vim.diagnostic.severity.INFO] = {enabled = false, icon = ''},
                [vim.diagnostic.severity.HINT] = {enabled = true, icon = ''}
            },

            -- 当前缓冲区
            current = {buffer_index = true, icon = '󰘔'},

            -- 非活动缓冲区
            inactive = {button = '×'}
        },

        -- ===== 其他设置 =====
        maximum_padding = 2,
        minimum_padding = 1,
        maximum_length = 30,
        semantic_letters = true,
        letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP'
    },
    keys = {
        {'<A-h>', '<Cmd>BufferPrevious<CR>', desc = 'Previous buffer'},
        {'<A-l>', '<Cmd>BufferNext<CR>', desc = 'Next buffer'},
        {'<leader>bb', '<Cmd>BufferPick<CR>', desc = 'Pick buffer'}
    },
    config = function(_, opts)
        -- 应用配置
        require('barbar').setup(opts)

        -- ===== 自定义快捷键 =====
        local map = vim.keymap.set

        -- 快速跳转缓冲区 (Alt + 1-9)
        for i = 1, 9 do
            map('n', ('<A-%s>'):format(i), ('<Cmd>BufferGoto %s<CR>'):format(i),
                {desc = ('Go to buffer %s'):format(i)})
        end
        map('n', '<A-0>', '<Cmd>BufferLast<CR>', {desc = 'Go to last buffer'})

        -- 快速关闭当前缓冲区
        vim.keymap.set('n', '<leader>bd', ':BufferClose<CR>',
                       {desc = 'Close current buffer'})

        -- 如果使用 which-key.nvim，可以添加描述
        if pcall(require, 'which-key') then
            local wk = require('which-key')
            wk.register({
                ['<leader>b'] = {name = '+buffer'},
                ['<leader>w'] = {name = '+window'}
            })
        end
    end
}
