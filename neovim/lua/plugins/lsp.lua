return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				-- rust_analyzer = {},
			},
		},
	},

	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			opts.PATH = "append"
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "rust-analyzer" })
			end
		end,
	},

	{ "lvimuser/lsp-inlayhints.nvim", opts = {
		inlay_hints = {
			only_current_line = true,
		},
	} },
}
