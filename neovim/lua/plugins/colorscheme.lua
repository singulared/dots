return {
	{
		"catppuccin/nvim",
		lazy = true,
		name = "catppuccin",
		version = false,
		opts = {
			flavour = "frappe",
			color_overrides = {
				frappe = {
					base = "#2b2d37",
					mantle = "#24262d",
					crust = "#202023",
				},
			},
			integrations = {
				cmp = true,
				leap = true,
				notify = false,
				illuminate = true,
				neotree = true,
				neogit = true,
			},
		},
	},
}
