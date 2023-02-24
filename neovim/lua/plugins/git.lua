return {
	{
		"sindrets/diffview.nvim",
	},
	{
		"TimUntersberger/neogit",
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
