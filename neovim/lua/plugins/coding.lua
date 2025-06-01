return {
	{
		"echasnovski/mini.pairs",
		opts = {
			mappings = {
				[" "] = { action = "open", pair = "  ", neigh_pattern = "[%(%[{][%)%]}]" },
			},
		},
	},

	{
		"saghen/blink.cmp",
		-- version = false,
		opts = {
			keymap = {
				preset = "enter",

				["<Tab>"] = {
					"select_next",
					"snippet_forward",
					"fallback",
				},

				["<S-Tab>"] = {
					"select_prev",
					"snippet_backward",
					"fallback",
				},
			},
		},
	},

	-- {
	-- 	"L3MON4D3/LuaSnip",
	-- 	keys = function()
	-- 		return {}
	-- 	end,
	-- },

	-- {
	-- 	"hrsh7th/nvim-cmp",
	-- 	version = false,
	-- 	dependencies = {
	-- 		"hrsh7th/cmp-emoji",
	-- 		{
	-- 			"garymjr/nvim-snippets",
	-- 			opts = {
	-- 				friendly_snippets = true,
	-- 			},
	-- 			dependencies = { "rafamadriz/friendly-snippets" },
	-- 		},
	-- 	},
	-- 	---@param opts cmp.ConfigSchema
	-- 	opts = function(_, opts)
	-- 		table.insert(opts.sources, { name = "emoji" })
	-- 		table.insert(opts.sources, { name = "lazydev", group_index = 0 })
	-- 		local has_words_before = function()
	-- 			unpack = unpack or table.unpack
	-- 			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	-- 			return col ~= 0
	-- 				and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	-- 		end
	--
	-- 		local cmp = require("cmp")
	-- 		local lspkind = require("lspkind")
	--
	-- 		opts.completion = {
	-- 			-- completeopt = "menu,menuone,noinsert,noselect,preview",
	-- 			-- completeopt = "menu,menuone,noselect",
	-- 			completeopt = "menu,menuone,noinsert,noselect",
	-- 		}
	-- 		opts.preselect = cmp.PreselectMode.None
	--
	-- 		-- table.insert(opts.formatting, {
	-- 		-- format = lspkind.cmp_format({
	-- 		-- 	mode = "symbol", -- show only symbol annotations
	-- 		-- 	maxwidth = 200, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
	-- 		-- 	-- can also be a function to dynamically calculate max width such as
	-- 		-- 	-- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
	-- 		-- 	ellipsis_char = "…", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
	-- 		-- 	show_labelDetails = true, -- show labelDetails in menu. Disabled by default
	-- 		--
	-- 		-- 	-- The function below will be called before any actual modifications from lspkind
	-- 		-- 	-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
	-- 		-- 	before = function(entry, vim_item)
	-- 		-- 		return vim_item
	-- 		-- 	end,
	-- 		-- }),
	-- 		--
	-- 		-- 	format = function(entry, item)
	-- 		-- 		local icons = LazyVim.config.icons.kinds
	-- 		-- 		if icons[item.kind] then
	-- 		-- 			item.kind = icons[item.kind] .. item.kind
	-- 		-- 		end
	-- 		--
	-- 		-- 		local widths = {
	-- 		-- 			abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
	-- 		-- 			menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
	-- 		-- 		}
	-- 		--
	-- 		-- 		for key, width in pairs(widths) do
	-- 		-- 			if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
	-- 		-- 				item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
	-- 		-- 			end
	-- 		-- 		end
	-- 		--
	-- 		-- 		return item
	-- 		-- 	end,
	-- 		-- })
	--
	-- 		opts.mapping = vim.tbl_extend("force", opts.mapping, {
	-- 			-- ["<CR>"] = cmp.mapping.confirm({
	-- 			-- 	-- behavior = cmp.ConfirmBehavior.Replace,
	-- 			-- 	select = true,
	-- 			-- }),
	-- 			["<CR>"] = cmp.mapping({
	-- 				i = function(fallback)
	-- 					if cmp.visible() and cmp.get_active_entry() then
	-- 						cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
	-- 					else
	-- 						fallback()
	-- 					end
	-- 				end,
	-- 				s = cmp.mapping.confirm({ select = true }),
	-- 				c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
	-- 			}),
	-- 			["<Tab>"] = cmp.mapping(function(fallback)
	-- 				if cmp.visible() then
	-- 					-- cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
	-- 					cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
	-- 				elseif vim.snippet.active({ direction = 1 }) then
	-- 					vim.schedule(function()
	-- 						vim.snippet.jump(1)
	-- 					end)
	-- 				elseif has_words_before() then
	-- 					cmp.complete()
	-- 				else
	-- 					fallback()
	-- 				end
	-- 			end, { "i", "s" }),
	-- 			["<S-Tab>"] = cmp.mapping(function(fallback)
	-- 				if cmp.visible() then
	-- 					-- cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
	-- 					cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
	-- 				elseif vim.snippet.active({ direction = -1 }) then
	-- 					vim.schedule(function()
	-- 						vim.snippet.jump(-1)
	-- 					end)
	-- 				else
	-- 					fallback()
	-- 				end
	-- 			end, { "i", "s" }),
	-- 		})
	-- 	end,
	-- },

	-- {
	-- 	"hrsh7th/nvim-cmp",
	-- 	version = false,
	-- 	dependencies = {
	-- 		"hrsh7th/cmp-emoji",
	-- 	},
	-- 	---@param opts cmp.ConfigSchema
	-- 	opts = function(_, opts)
	-- 		local has_words_before = function()
	-- 			unpack = unpack or table.unpack
	-- 			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	-- 			return col ~= 0
	-- 				and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	-- 		end
	--
	-- 		local luasnip = require("luasnip")
	-- 		local cmp = require("cmp")
	-- 		-- opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "crates" } }))
	-- 		opts.completion = {
	-- 			completeopt = "menuone,noinsert,noselect",
	-- 		}
	-- 		opts.preselect = cmp.PreselectMode.None
	-- 		opts.mapping = vim.tbl_extend("force", opts.mapping, {
	-- 			["<CR>"] = cmp.mapping.confirm({
	-- 				-- behavior = cmp.ConfirmBehavior.Replace,
	-- 				select = false,
	-- 			}),
	-- 			["<Tab>"] = cmp.mapping(function(fallback)
	-- 				if cmp.visible() then
	-- 					cmp.select_next_item()
	-- 				-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
	-- 				-- they way you will only jump inside the snippet region
	-- 				elseif luasnip.expand_or_locally_jumpable() then
	-- 					luasnip.expand_or_jump()
	-- 				elseif has_words_before() then
	-- 					cmp.complete()
	-- 				else
	-- 					fallback()
	-- 				end
	-- 			end, { "i", "s" }),
	-- 			["<S-Tab>"] = cmp.mapping(function(fallback)
	-- 				if cmp.visible() then
	-- 					cmp.select_prev_item()
	-- 				elseif luasnip.jumpable(-1) then
	-- 					luasnip.jump(-1)
	-- 				else
	-- 					fallback()
	-- 				end
	-- 			end, { "i", "s" }),
	-- 		})
	-- 		-- opts.formatting = vim.tbl_extend("force", opts.formatting, {
	-- 		-- 	["format"] = function(_, item)
	-- 		-- 		local icons = LazyVim.config.icons.kinds
	-- 		-- 		if icons[item.kind] then
	-- 		-- 			item.kind = icons[item.kind] .. item.kind
	-- 		-- 		end
	-- 		-- 		return item
	-- 		-- 	end,
	-- 		-- })
	-- 	end,
	-- },
}
