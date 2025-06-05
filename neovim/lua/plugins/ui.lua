return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		opts = {
			window = {
				mappings = {
					["o"] = "open",
				},
			},
		},
	},
	{
		"ibhagwan/fzf-lua",
		version = false,
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- calling `setup` is optional for customization
			require("fzf-lua").setup({ "skim" })
		end,
	},
	{
		"folke/noice.nvim",
		version = false,
		config = function()
			require("noice").setup({
				lsp = {
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				presets = {
					bottom_search = true,
					command_palette = true,
					long_message_to_split = true,
					inc_rename = false,
					lsp_doc_border = true,
				},
			})
		end,
	},
	{
		"folke/snacks.nvim",
		version = false,
		opts = {
			dashboard = {
				width = 80,
				sections = {
					{
						pane = 1,
						{
							section = "terminal",
							cmd = "chafa ~/Downloads/rustacean-orig-noshadow.png --format symbols --symbols vhalf --size 75 --stretch; sleep .1",
							height = 27,
							width = 75,
							padding = 1,
						},
						-- {
						-- 	section = "terminal",
						-- 	icon = " ",
						-- 	cmd = 'echo -e "Validator\t\t\t\t\t $(gh api repos/rambler-digital-solutions/actix-web-validator | jq -r \'" \\(.stargazers_count)  \\(.open_issues_count)"\')"',
						-- 	height = 2,
						-- 	padding = 1,
						-- 	ttl = 5 * 60,
						-- 	width = 70,
						-- 	indent = 3,
						-- },
					},
					{
						pane = 1,
						-- { section = "header" },
						{ section = "keys", gap = 1 },
						-- {
						-- 	icon = " ",
						-- 	title = "Recent Files",
						-- 	section = "recent_files",
						-- 	indent = 2,
						-- 	padding = { 2, 2 },
						-- },
						{ icon = " ", title = "Projects", section = "projects", indent = 2, padding = 2 },
						{ section = "startup" },
					},
					{
						pane = 2,
					},
					{
						pane = 2,
						{
							section = "terminal",
							icon = " ",
							cmd = 'echo -e "Hitbox\t\t\t\t\t\t\t\t $(gh api repos/hit-box/hitbox | jq -r \'" \\(.stargazers_count)  \\(.open_issues_count)"\')"',
							title = "Github stats",
							height = 5,
							padding = 1,
							ttl = 5 * 60,
							indent = 3,
						},
					},
					{
						pane = 2,
						icon = " ",
						desc = "Browse Repo",
						padding = 1,
						key = "b",
						action = function()
							Snacks.gitbrowse()
						end,
					},
					function()
						local in_git = Snacks.git.get_root() ~= nil
						local cmds = {
							{
								title = "Notifications",
								cmd = "gh notify -s -a -n5",
								action = function()
									vim.ui.open("https://github.com/notifications")
								end,
								key = "n",
								icon = " ",
								height = 5,
								enabled = true,
							},
							{
								title = "Open Issues",
								cmd = "gh issue list -L 3",
								key = "i",
								action = function()
									vim.fn.jobstart("gh issue list --web", { detach = true })
								end,
								icon = " ",
								height = 7,
							},
							{
								icon = " ",
								title = "Open PRs",
								cmd = "gh pr list -L 3",
								key = "P",
								action = function()
									vim.fn.jobstart("gh pr list --web", { detach = true })
								end,
								height = 7,
							},
							{
								icon = " ",
								title = "Git Status",
								cmd = "git --no-pager diff --stat -B -M -C",
								height = 10,
							},
						}
						return vim.tbl_map(function(cmd)
							return vim.tbl_extend("force", {
								pane = 2,
								section = "terminal",
								enabled = in_git,
								padding = 1,
								ttl = 5 * 60,
								indent = 3,
							}, cmd)
						end, cmds)
					end,
				},
				preset = {
					keys = {
						{
							icon = " ",
							key = "f",
							desc = "Find File",
							action = ":lua Snacks.dashboard.pick('files')",
						},
						{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
						{
							icon = " ",
							key = "g",
							desc = "Find Text",
							action = ":lua Snacks.dashboard.pick('live_grep')",
						},
						{
							icon = " ",
							key = "r",
							desc = "Recent Files",
							action = ":lua Snacks.dashboard.pick('oldfiles')",
						},
						{
							icon = " ",
							key = "c",
							desc = "Config",
							action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
						},
						{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
						{ icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
						{ icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
						{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
					},
				},
			},
		},
	},
}
