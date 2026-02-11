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
				-- rust_analyzer = {
				-- 	mason = false,
				-- 	completions = {
				-- 		completeFunctionCalls = true,
				-- 	},
				-- 	settings = {
				-- 		completions = {
				-- 			completeFunctionCalls = true,
				-- 		},
				-- 		rust_analyzer = {
				-- 			completion = {
				-- 				fullFunctionSignatures = { enabled = true },
				-- 			},
				-- 			diagnostics = {
				-- 				enable = true,
				-- 				disabled = { "unresolved-proc-macro" },
				-- 				enableExperimental = true,
				-- 			},
				-- 		},
				-- 	},
				-- },
				-- pylsp = {
				-- 	settings = {
				-- 		pylsp = {
				-- 			plugins = {
				-- 				ruff = {
				-- 					enabled = true,
				-- 					extendSelect = { "I" },
				-- 				},
				-- 				black = { enabled = true },
				-- 				autopep8 = { enabled = false },
				-- 				pycodestyle = { enabled = false },
				-- 				pyflakes = { enabled = false },
				-- 				pylint = { enabled = false },
				-- 				yapf = { enabled = false },
				-- 				jedi = {
				-- 					extra_paths = {
				-- 						io.popen(
				-- 							"python -c \"import sys; print(next((p for p in sys.path if 'site-packages' in p), ''))\"",
				-- 							"r"
				-- 						):read(),
				-- 					},
				-- 				},
				-- 				pylsp_mypy = {
				-- 					enabled = true,
				-- 				},
				-- 			},
				-- 		},
				-- 	},
				-- },
			},
		},
	},
	{
		"onsails/lspkind.nvim",
		version = false,
	},
	-- { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
	{
		"mason-org/mason.nvim",
		-- version = "^1.0.0",
		opts = function(_, opts)
			opts.PATH = "append"
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "cspell", "json-lsp", "yaml-language-server" })
			end
		end,
	},
	{
		"mfussenegger/nvim-lint",
		opts = {
			-- Event to trigger linters
			events = { "BufWritePost", "BufReadPost", "InsertLeave" },
			linters_by_ft = {
				-- ["*"] = { "cspell" },
				fish = { "fish" },
				-- Use the "*" filetype to run linters on all filetypes.
				-- ['*'] = { 'global linter' },
				-- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
				-- ['_'] = { 'fallback linter' },
				-- ["*"] = { "typos" },
			},
			-- LazyVim extension to easily override linter options
			-- or add custom linters.
			---@type table<string,table>
			linters = {
				-- -- Example of using selene only when a selene.toml file is present
				-- selene = {
				--   -- `condition` is another LazyVim extension that allows you to
				--   -- dynamically enable/disable linters based on the context.
				--   condition = function(ctx)
				--     return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
				--   end,
				-- },
			},
		},
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				fish = { "fish_indent" },
				sh = { "shfmt" },
				-- ["*"] = { "codespell" },
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
					-- -- nls.builtins.formatting.stylua,
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
