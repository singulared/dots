return {
	{
		"saecki/crates.nvim",
		event = { "BufReadPre Cargo.toml" },
		config = function()
			require("crates").setup()
		end,
	},
}
