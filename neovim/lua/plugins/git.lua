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
			integrations = {
				diffview = true,
			},
		},
	},
}
