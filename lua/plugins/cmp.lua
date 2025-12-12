return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},

			formatting = {
				format = function(entry, item)
					local max_width = 30 -- 你可以改，比如 30 / 50
					if #item.abbr > max_width then
						item.abbr = string.sub(item.abbr, 1, max_width) .. "…"
					end
					return item
				end,
			},

			completion = {
				keyword_length = 5,
			},

			sorting = {
				priority_weight = 2,
			},

			mapping = cmp.mapping.preset.insert({

				-- 回车：确认补全
				["<CR>"] = cmp.mapping.confirm({ select = true }),

				-- 手动触发补全
				["<C-Space>"] = cmp.mapping.complete(),

				-- TAB 智能行为：补全 / snippet / 缩进
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback() -- 正常缩进
					end
				end, { "i", "s" }),

				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),

			sources = {
				{ name = "nvim_lsp" },
				{ name = "path" },
				{ name = "buffer" },
				{ name = "luasnip" },
			},
		})
	end,
}
