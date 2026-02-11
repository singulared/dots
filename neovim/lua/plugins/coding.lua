return {
	{
		"nvim-mini/mini.pairs",
		opts = {
			mappings = {
				[" "] = { action = "open", pair = "  ", neigh_pattern = "[%(%[{][%)%]}]" },
			},
		},
	},

	{
		"saghen/blink.cmp",
		-- version = false,
		opts = {
			keymap = {
				preset = "enter",

				["<Tab>"] = {
					"select_next",
					"snippet_forward",
					"fallback",
				},

				["<S-Tab>"] = {
					"select_prev",
					"snippet_backward",
					"fallback",
				},
			},
		},
	},
}
