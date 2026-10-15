return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			inlay_hints = {
				enabled = false,
			},
			servers = {
				cucumber_language_server = {
					settings = {
						cucumber = {
							features = { "**/tests/features/*.feature" },
							glue = { "**/src/**/*.rs", "**/tests/*.rs" },
						},
					},
				},
				yamlls = {
					settings = {
						yaml = {
							customTags = {
								"!Header mapping",
								"!Header scalar",
								"!Path mapping",
								"!Path scalar",
								"!Query mapping",
								"!Query scalar",
								"!Body mapping",
								"!Body scalar",
								"!Status mapping",
								"!Status scalar",
							},
						},
					},
				},
			},
		},
	},
	{
		"mason-org/mason.nvim",
		opts = {
			-- prefer system binaries (e.g. rust-analyzer from rustup) over Mason ones
			PATH = "append",
			ensure_installed = { "cspell" },
		},
	},
	{
		"nvimtools/none-ls.nvim",
		version = false,
		opts = function()
			local nls = require("null-ls")
			local cspell = require("cspell")
			return {
				sources = {
					cspell.diagnostics.with({
						method = nls.methods.DIAGNOSTICS_ON_SAVE,
					}),
					cspell.code_actions,
				},
			}
		end,
	},
}
