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
				vim.list_extend(
					opts.ensure_installed,
					{ "rust-analyzer", "cspell", "json-lsp", "yaml-language-server" }
				)
			end
		end,
	},

	{
		"lvimuser/lsp-inlayhints.nvim",
		version = false,
		opts = {
			inlay_hints = {
				only_current_line = true,
			},
		},
	},

	{
		"jose-elias-alvarez/null-ls.nvim",
		opts = function()
			local nls = require("null-ls")
			return {
				sources = {
					nls.builtins.diagnostics.cspell,
					nls.builtins.diagnostics.flake8,
					nls.builtins.code_actions.cspell,
					nls.builtins.formatting.stylua,
				},
			}
		end,
	},
}
