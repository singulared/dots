-- peek opens the preview as a separate window; under sway, split so it lands next to the editor
local function sway(cmd)
	if vim.env.SWAYSOCK then
		vim.fn.system({ "swaymsg", cmd })
	end
end

local function open()
	local peek = require("peek")
	if not peek.is_open() and vim.bo.filetype == "markdown" then
		sway("split horizontal")
		peek.open()
	end
end

local function close()
	local peek = require("peek")
	if peek.is_open() then
		peek.close()
		sway("move left")
	end
end

return {
	-- fork of toppair/peek.nvim that builds against libwebkitgtk-6.0
	"singulared/peek.nvim",
	version = false,
	build = "deno task --quiet build:fast",
	cmd = { "PeekOpen", "PeekClose" },
	keys = {
		{
			"<leader>mp",
			function()
				if require("peek").is_open() then
					close()
				else
					open()
				end
			end,
			ft = "markdown",
			desc = "toggle markdown preview",
		},
	},
	config = function()
		vim.api.nvim_create_user_command("PeekOpen", open, {})
		vim.api.nvim_create_user_command("PeekClose", close, {})
	end,
}
