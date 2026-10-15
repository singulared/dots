return {
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewFileHistory" },
	},
	{
		"NeogitOrg/neogit",
		version = false,
		cmd = "Neogit",
		dependencies = {
			"sindrets/diffview.nvim",
		},
		opts = {},
	},
}
