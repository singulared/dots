return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
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
				pylsp = {
					settings = {
						pylsp = {
							plugins = {
								ruff = {
									enabled = true,
									extendSelect = { "I" },
								},
								black = { enabled = true },
								autopep8 = { enabled = false },
								pycodestyle = { enabled = false },
								pyflakes = { enabled = false },
								pylint = { enabled = false },
								yapf = { enabled = false },
								jedi = {
									extra_paths = {
										io.popen(
											"python -c \"import sys; print(next((p for p in sys.path if 'site-packages' in p), ''))\"",
											"r"
										):read(),
									},
								},
								pylsp_mypy = {
									enabled = true,
								},
							},
						},
					},
				},
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
					nls.builtins.formatting.stylua,
				},
			}
		end,
	},
}
