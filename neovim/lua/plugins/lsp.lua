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
	{
		"mrcjkb/rustaceanvim",
		version = false,
		ft = { "rust" },
		opts = {
			server = {
				on_attach = function(_, bufnr)
					vim.keymap.set("n", "<leader>cR", function()
						vim.cmd.RustLsp("codeAction")
					end, { desc = "Code Action", buffer = bufnr })
					vim.keymap.set("n", "<leader>dr", function()
						vim.cmd.RustLsp("debuggables")
					end, { desc = "Rust Debuggables", buffer = bufnr })
				end,
				completions = {
					completeFunctionCalls = true,
				},
				default_settings = {
					-- rust-analyzer language server configuration
					["rust-analyzer"] = {
						completion = {
							fullFunctionSignatures = { enabled = true },
						},
						cargo = {
							allFeatures = true,
							-- features = { "all" },
							loadOutDirsFromCheck = true,
							buildScripts = {
								enable = true,
							},
						},
						-- diagnostics = { disabled = { "unresolved-proc-macro" } },
						-- diagnostics = { disabled = { "unresolved-proc-macro" }, enableExperimental = true },
						diagnostics = { enableExperimental = true },
						-- Add clippy lints for Rust.
						checkOnSave = true,
						procMacro = {
							enable = true,
							ignored = {
								["async-trait"] = vim.NIL,
								["napi-derive"] = { "napi" },
								["async-recursion"] = { "async_recursion" },
							},
							enableExperimental = true,
						},
					},
				},
			},
		},
		config = function(_, opts)
			vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
			if vim.fn.executable("rust-analyzer") == 0 then
				LazyVim.error(
					"**rust-analyzer** not found in PATH, please install it.\nhttps://rust-analyzer.github.io/",
					{ title = "rustaceanvim" }
				)
			end
		end,
	},
}
