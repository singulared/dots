return {
	"toppair/peek.nvim",
	version = false,
	event = { "VeryLazy" },
	build = "deno task --quiet build:fast",
	config = function()
		local peek = require("peek")
		-- peek.setup({ app = { "chromium", "--new-window" } })
		-- peek.setup({ app = "webview", auto_load = true })

		vim.api.nvim_create_user_command("PeekOpen", function()
			if not peek.is_open() and vim.bo[vim.api.nvim_get_current_buf()].filetype == "markdown" then
				vim.fn.system("swaymsg split horizontal")
				peek.open()
			end
		end, {})

		vim.api.nvim_create_user_command("PeekClose", function()
			if peek.is_open() then
				peek.close()
				vim.fn.system("swaymsg move left")
			end
		end, {})

		vim.keymap.set("n", "<leader>mp", function()
			if peek.is_open() then
				peek.close()
				vim.fn.system("swaymsg move left")
			else
				if vim.bo[vim.api.nvim_get_current_buf()].filetype == "markdown" then
					vim.fn.system("swaymsg split horizontal")
					peek.open()
				end
			end
		end, { desc = "toggle markdown preview" })
	end,
}
