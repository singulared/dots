return {
	{
		"catppuccin/nvim",
		lazy = true,
		name = "catppuccin",
		version = "*",
		opts = {
			flavour = "frappe",
			color_overrides = {
				frappe = {
					base = "#2b2d37",
				},
			},
			integrations = {
				leap = true,
				notify = false,
				illuminate = true,
			},
		},
	},
}
