return {
	{
		"sindrets/diffview.nvim",
	},
	{
		"NeogitOrg/neogit",
		version = false,
		dependencies = {
			"sindrets/diffview.nvim",
		},
		opts = {
			disable_builtin_notifications = true,
			disable_commit_confirmation = true,
			integrations = {
				diffview = true,
			},
		},
	},
}
